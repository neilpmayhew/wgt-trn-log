const std = @import("std");

const Exercise: type = struct {
    exercise_id: u8,
    exercise_name: []const u8,
    exercise_type: []const u8,
    pub fn format(
        exercise: Exercise,
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = try writer.print("{} ({})", .{ exercise.exercise_name, exercise.exercise_type });
    }
};
const LoggedSet = struct {
    exercise: Exercise,
    start_timestamp: i64,
    end_timestamp: i64,
    weight: u8,
    reps: u8,
    rir: u4,

    pub fn format(
        logged_set: LoggedSet,
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = try writer.print("{}: {}x{} :rir {}", .{ logged_set.exercise, logged_set.weight, logged_set.reps, logged_set.rir });
    }
};
