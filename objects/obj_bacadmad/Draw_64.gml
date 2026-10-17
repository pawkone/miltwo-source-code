if (!in_camera())
{
    var _x = x - camera_get_view_x(view_camera[0]);
    _x = clamp(_x, 100, 960 - 100);
    var _y = y - camera_get_view_y(view_camera[0]);
    _y = clamp(_y, 100, 540 - 100);
    draw_sprite(spr_bacadmadLocate, locatorIndex, _x, _y);
}
