const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "simple-browser",
        .root_source_file = b.path(b.pathJoin(&.{ "src", "main.zig" })),
        .target = target,
        .optimize = optimize,
    });

    exe.linkLibC();

    exe.addLibraryPath(b.path(b.pathJoin(&.{ "ultralight", "bin" })));
    exe.addIncludePath(b.path(b.pathJoin(&.{ "ultralight", "include" })));
    exe.linkSystemLibrary("Ultralight");
    exe.linkSystemLibrary("AppCore");

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the browser");
    run_step.dependOn(&run_cmd.step);
}