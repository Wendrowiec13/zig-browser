const std = @import("std");
const ul = @cImport({
    @cInclude("Ultralight/CAPI.h");
    @cInclude("AppCore/CAPI.h");
});

pub fn main() !void {

    const settings = ul.ulCreateSettings();
    defer ul.ulDestroySettings(settings);

    const config = ul.ulCreateConfig();
    defer ul.ulDestroyConfig(config);

    ul.ulConfigSetResourcePathPrefix(config, ul.ulCreateString("resources/"));

    const app = ul.ulCreateApp(settings, config);
    defer ul.ulDestroyApp(app);

    const window = ul.ulCreateWindow(
        ul.ulAppGetMainMonitor(app),
        1920,
        1080,
        false,
        ul.kWindowFlags_Titled | ul.kWindowFlags_Resizable
    );
    defer ul.ulDestroyWindow(window);

    ul.ulWindowSetTitle(window, "Google Browser");

    const overlay = ul.ulCreateOverlay(window, 1920, 1080, 0, 0);
    defer ul.ulDestroyOverlay(overlay);

    const view = ul.ulOverlayGetView(overlay);
    ul.ulViewLoadURL(view, ul.ulCreateString("https://google.com"));

    ul.ulAppRun(app);
}