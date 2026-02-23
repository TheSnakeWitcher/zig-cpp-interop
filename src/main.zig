const std = @import("std");
const c = @cImport({

    @cInclude("stdio.h");

    // import definitions for ../cpp-src/wrapper.h
    // we can use this notation thanks to `exe.addIncludePath(cpath)` 
    // see build.zig:19
    @cInclude("wrapper.h");
});


pub fn main() !void {
    std.debug.print("Hello from zig main.\n", .{});

    _ = c.printf("print using stdio\n"); // using `printf()` from `stdio` imported with `@cImport`

    c.say_hi(); // using `say_hi()` from @cImport

    say_hi(); // using extern declaration directly
}

// This function is provided by c++ 
// It is defined here so can be used directly from zig
// See ../cpp-src/wrapper.h
extern fn say_hi() void;

// This function is not called from Zig, but it's instead exported and called from C++
export fn hello_from_zig() void {
    std.debug.print("Hello from zig hello_from_zig().\n", .{});
}
