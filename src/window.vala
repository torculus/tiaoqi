/* window.vala
 *
 * Copyright 2018 torculus
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Cairo;
using Gtk;

namespace Tiaoqi {
	//[GtkTemplate (ui = "/org/gnome/Tiaoqi/window.ui")]
	public class Window : Gtk.ApplicationWindow {

		private const int SIZE = 30;

		public Window (Gtk.Application app) {
			Object (application: app);

			var drawingarea = new DrawingArea();
			drawingarea.draw.connect(on_draw);
			drawingarea.set_size_request(13*SIZE, 17*SIZE);
			add(drawingarea);
			drawingarea.show();
		}

		private bool on_draw (Widget da, Context ctx) {

		ctx.save();
		ctx.set_tolerance (0.1);
        ctx.set_dash (null, 0);

		// paint the background
        ctx.set_source_rgb(0.886, 0.836, 0.625);
        ctx.set_line_width(3);
		ctx.move_to(0,0);
		ctx.rel_line_to(da.get_allocated_width(), 0);
		ctx.rel_line_to(0, da.get_allocated_height());
		ctx.rel_line_to(-1*da.get_allocated_width(), 0);
		ctx.close_path();
		ctx.fill();

		int[,] board = {{-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
                        {-1, -1, -1, -1, -1, -1, 14, -1, -1, -1, -1, -1, -1},
                        {-1, -1, -1, -1, -1, 14, 14, -1, -1, -1, -1, -1, -1},
                        {-1, -1, -1, -1, -1, 14, 14, 14, -1, -1, -1, -1, -1},
                        {-1, -1, -1, -1, 14, 14, 14, 14, -1, -1, -1, -1, -1},
                        {63, 63, 63, 63,  0,  0,  0,  0,  0, 25, 25, 25, 25},
                        {63, 63, 63,  0,  0,  0,  0,  0,  0, 25, 25, 25, -1},
                        {-1, 63, 63,  0,  0,  0,  0,  0,  0,  0, 25, 25, -1},
                        {-1, 63,  0,  0,  0,  0,  0,  0,  0,  0, 25, -1, -1},
                        {-1, -1,  0,  0,  0,  0,  0,  0,  0,  0,  0, -1, -1},
                        {-1, 52,  0,  0,  0,  0,  0,  0,  0,  0, 36, -1, -1},
                        {-1, 52, 52,  0,  0,  0,  0,  0,  0,  0, 36, 36, -1},
                        {52, 52, 52,  0,  0,  0,  0,  0,  0, 36, 36, 36, -1},
                        {52, 52, 52, 52,  0,  0,  0,  0,  0, 36, 36, 36, 36},
                        {-1, -1, -1, -1, 41, 41, 41, 41, -1, -1, -1, -1, -1},
                        {-1, -1, -1, -1, -1, 41, 41, 41, -1, -1, -1, -1, -1},
                        {-1, -1, -1, -1, -1, 41, 41, -1, -1, -1, -1, -1, -1},
                        {-1, -1, -1, -1, -1, -1, 41, -1, -1, -1, -1, -1, -1}};

        for (int i=0; i<18; i++) {
            for (int j=0; j<13; j++) {

                // set holes in the board
                if (board[i, j] >= 0) {
                    ctx.new_path();

                    switch(board[i,j]) {
                        case 14:
                            ctx.set_source_rgb(0.379, 0.543, 0.75);
                            break;
                        case 25:
                            ctx.set_source_rgb(0.754, 0.723, 0.031);
                            break;
                        case 36:
                            ctx.set_source_rgb(0.113, 0, 0.75);
                            break;
                        case 41:
                            ctx.set_source_rgb(0.305, 0.773, 0.23);
                            break;
                        case 52:
                            ctx.set_source_rgb(0.742, 0.145, 0.566);
                            break;
                        case 63:
                            ctx.set_source_rgb(0.742, 0, 0.023);
                            break;
                        default:
                            ctx.set_source_rgb(0.75, 0.75, 0.75);
                            break;
                    }

                    //offset the even rows to make it symmetrical
                    if (i % 2 == 0) {
                        //ctx.arc(x given by column, y given by row, ...);
                        ctx.arc(SIZE*(j+1), SIZE*(i-0.5), 10, 0, 2*Math.PI);
                    } else {
                        ctx.arc(SIZE*(j+0.5), SIZE*(i-0.5), 10, 0, 2*Math.PI);
                    }

                    if (board[i,j] == 0) {
                        ctx.stroke();
                    } else {
                        ctx.fill();
                    }

                }
            }
        }

        return true;
    }

	}
}
