const std = @import("std");

const LoggedSet = struct {
    timestamp: i64,
    weight: u8,
    reps: u8,
    rir: u4,

    pub fn format(
        logged_set: LoggedSet,
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = try writer.print("{}x{} :rir {}\n", .{ logged_set.weight, logged_set.reps, logged_set.rir });
    }
};

const LoggedExercise = struct {
    exercise_name: []const u8,
    logged_sets: []const LoggedSet,

    pub fn format(
        logged_exercise: LoggedExercise,
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = try writer.print("## {s}\n", .{logged_exercise.exercise_name});

        for (logged_exercise.logged_sets) |logged_set| {
            _ = try writer.print("{}\n", .{logged_set});
        }
    }
};

pub fn LogSet() !LoggedSet {
    //

}

pub fn main() !void {
    // const logged_set = LoggedSet{
    //     .timestamp = std.time.milliTimestamp(),
    //     .weight = 70,
    //     .reps = 5,
    //     .rir = 2,
    // };

    const logged_exercise = LoggedExercise{
        .exercise_name = "Squat",
        .logged_sets = &.{.{ .timestamp = std.time.milliTimestamp(), .weight = 70, .reps = 5, .rir = 2 }},
    };

    std.debug.print("{}", .{logged_exercise});

    // const allocator = std.heap.page_allocator;
    // const result = try std.process.Child.run(.{
    //     .allocator = allocator,
    //     .argv = &[_][]const u8{ "date", "--iso-8601=seconds" },
    // });
    // defer allocator.free(result.stderr);
    // defer allocator.free(result.stdout);
    //
    // if (result.term.Exited != 0) {
    //     return error.DateCommandFailed;
    // }
    // const stdout = std.io.getStdOut().writer();
    // const stdin = std.io.getStdIn().reader();
    //
    // try stdout.print("# {s}\n", .{result.stdout});
    //
    // try stdout.print("## {s}\n", .{"Squat"});
    // var memory: [100]u8 = undefined;
    // var buffer: []u8 = &memory;
    //
    // std.debug.print("wgt: ", .{});
    // const wgt = (try stdin.readUntilDelimiterOrEof(buffer, '\n')).?;
    // buffer = buffer[wgt.len..];
    //
    // std.debug.print("reps: ", .{});
    // const reps = (try stdin.readUntilDelimiterOrEof(buffer, '\n')).?;
    // buffer = buffer[reps.len..];
    //
    // std.debug.print("{s}x{s}\n", .{ wgt, reps });
}
