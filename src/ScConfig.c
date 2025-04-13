#include <stdio.h>
#include <string.h>
#include <ncurses.h>
#include <menu.h>

#include <stdlib.h>

int main(int argc, char *argv[]) {
    // Initialize ncurses
    initscr();
    cbreak();
    noecho();
    keypad(stdscr, TRUE);

    // Create a menu
    const char *choices[] = {
        "Option 1",
        "Option 2",
        "Option 3",
        "Exit",
        (char *)NULL,
    };
    int n_choices = sizeof(choices) / sizeof(choices[0]);

    ITEM **items = (ITEM **)calloc(n_choices + 1, sizeof(ITEM *));
    for (int i = 0; i < n_choices; ++i) {
        items[i] = new_item(choices[i], "");
    }
    items[n_choices] = (ITEM *)NULL;

    MENU *menu = new_menu((ITEM **)items);
    mvprintw(LINES - 2, 0, "Press <ENTER> to select an option");
    post_menu(menu);
    refresh();

    int c;
    while ((c = getch()) != KEY_F(1)) {
        switch (c) {
            case KEY_DOWN:
                menu_driver(menu, REQ_DOWN_ITEM);
                break;
            case KEY_UP:
                menu_driver(menu, REQ_UP_ITEM);
                break;
            case 10: // Enter key
                mvprintw(LINES - 3, 0, "You selected: %s", item_name(current_item(menu)));
                refresh();
                break;
            default:
                break;
        }
        refresh();
    }

    // Cleanup
    unpost_menu(menu);
    free_menu(menu);
    for (int i = 0; i < n_choices; ++i) {
        free_item(items[i]);
    }
    free(items);

    endwin();
    return 0;
}