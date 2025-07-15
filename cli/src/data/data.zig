const std = @import("std");

pub const Exercise: type = struct {
    exercise_id: u8,
    exercise_name: []const u8,
    pub fn format(
        exercise: Exercise,
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = try writer.print("{s}", .{exercise.exercise_name});
    }
};
pub const PlannedSet = struct {
    exercise: Exercise,
    reps_min: u4,
    reps_max: u4,
    reps_in_reserve_goal: u4,
};

pub const LoggedSet = struct {
    exercise: Exercise,
    start_timestamp: i64,
    end_timestamp: i64,
    weight: u16,
    reps: u16,
    rir: u16,

    pub fn format(
        logged_set: LoggedSet,
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = try writer.print("{}: {}x{} :rir {}", .{ logged_set.exercise, logged_set.weight, logged_set.reps, logged_set.rir });
    }
};
