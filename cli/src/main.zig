const std = @import("std");
const data = @import("data");
pub fn main() !void {
    // const logged_set = LoggedSet{
    //     .timestamp = std.time.milliTimestamp(),
    //     .weight = 70,
    //     .reps = 5,
    //     .rir = 2,
    // };

    const exercise = data.Exercise{
        .exercise_id = 1,
        .exercise_name = "Squat",
        .exercise_type = "Barbell",
    };

    const 

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
