const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const pg = b.dependency("pg", .{
        .target = target,
        .optimize = optimize,
    });

    const check_step = b.step("check", "Verify all generated code compiles");

    // Each entry: { gen_dir, query_file, lib_name }
    const files = .{
        .{ "src/gen/managed/users.sql.zig", "src/gen/managed/models.zig", "managed-users" },
        .{ "src/gen/managed/tasks.sql.zig", "src/gen/managed/models.zig", "managed-tasks" },
        .{ "src/gen/unmanaged/users.sql.zig", "src/gen/unmanaged/models.zig", "unmanaged-users" },
        .{ "src/gen/unmanaged/tasks.sql.zig", "src/gen/unmanaged/models.zig", "unmanaged-tasks" },
        .{ "src/gen/unions/users.sql.zig", "src/gen/unions/models.zig", "unions-users" },
        .{ "src/gen/unions/tasks.sql.zig", "src/gen/unions/models.zig", "unions-tasks" },
        .{ "src/gen/unmanaged_unions/users.sql.zig", "src/gen/unmanaged_unions/models.zig", "unmanaged-unions-users" },
        .{ "src/gen/unmanaged_unions/tasks.sql.zig", "src/gen/unmanaged_unions/models.zig", "unmanaged-unions-tasks" },
    };

    inline for (files) |entry| {
        const query_path = entry[0];
        const models_path = entry[1];
        const lib_name = entry[2];

        const models_mod = b.createModule(.{
            .root_source_file = b.path(models_path),
            .target = target,
            .optimize = optimize,
        });
        models_mod.addImport("pg", pg.module("pg"));

        const mod = b.createModule(.{
            .root_source_file = b.path(query_path),
            .target = target,
            .optimize = optimize,
        });
        mod.addImport("pg", pg.module("pg"));
        mod.addImport("models.zig", models_mod);

        const lib = b.addLibrary(.{
            .name = lib_name,
            .root_module = mod,
        });
        check_step.dependOn(&lib.step);
    }
}
