const std = @import("std");
const data = @import("data");
const ArrayList = std.ArrayList;

fn input_wgt_reps() ![2]u16 {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [4]u8 = undefined;

    try stdout.print("wgt: ", .{});
    const wgt_str = try stdin.readUntilDelimiterOrEof(buf[0..], '\n');

    try stdout.print("'{s}'", .{buf});
    const wgt = try std.fmt.parseInt(u16, wgt_str, 10);

    try stdout.print("reps: ", .{});
    const reps_str = try stdin.readUntilDelimiterOrEof(buf[0..], '\n');
    const reps = try std.fmt.parseInt(u16, reps_str, 10);

    return .{ wgt, reps };
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var planned_session = ArrayList(data.PlannedSet).init(allocator);
    defer planned_session.deinit();

    const stdout = std.io.getStdOut().writer();

    const incline_bp = data.Exercise{ .exercise_id = 1, .exercise_name = "Dumbbell Incline Bench Press" };
    const pullover = data.Exercise{ .exercise_id = 2, .exercise_name = "Dumbbell Pullover" };

    try planned_session.append(data.PlannedSet{ .exercise = incline_bp, .reps_min = 8, .reps_max = 12, .reps_in_reserve_goal = 2 });
    try planned_session.append(data.PlannedSet{ .exercise = pullover, .reps_min = 8, .reps_max = 12, .reps_in_reserve_goal = 2 });

    var logged_set = ArrayList(data.LoggedSet).init(allocator);
    defer logged_set.deinit();

    for (planned_session.items) |planned_set| {
        try stdout.print("# {s}\n", .{planned_set.exercise.exercise_name});
        try stdout.print(":reps [{d}-{d}] :rir {d}\n", .{ planned_set.reps_min, planned_set.reps_max, planned_set.reps_in_reserve_goal });

        try stdout.print("\n\n", .{});

        _ = try input_wgt_reps();
    }

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
