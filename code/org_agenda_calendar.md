Org-Agenda as a Calendar
# Org-Agenda as a Calendar

I've been looking for an offline calendaring solution that will allow smooth syncing via Dropbox or an alternative. I originally tried
[Sunbird](https://www.mozilla.org/projects/calendar/sunbird/) but there was always issues with duplicate events. I've been wanting a plain-text
variant to avoid these issues, but the existing solutions are not ideal.

Simultaneously, I've been looking for an excuse to learn [org-mode](http://orgmode.org) for a while. It is always hyped as a terrific solution to any
outlining scenario (which, truly, calendaring is), but has a steep learning curve for anything past a very basic outline.

After spending months periodically searching online for a good tutorial on using org-mode as a calendar, I found no complete tutorial, but I began to
accumulate enough bits and pieces to figure out the setup. The below is both for my benefit, to document how my system works in the event of data-loss
or memory-loss, and to attempt a unified tutorial on org-mode calendaring.

This setup was accomplished on Emacs 24.3.50.1 (though I suspect earlier 24.x versions will suffice) with org-mode 8.0.3 (again, I suspect earlier 8.x
versions will work).

### Preliminaries

First, decide where you are going to keep your files. I'd suggest their own directly, maybe `~/.emacs.d/org`. Create the directory. `touch` a file in
there named `whatever.org`. You'll probably want multiple files for each type of calender (to avoid any one getting overwhelmingly large) but you can
create the rest later.

Orgmode's categories are analogous to individual calendars in Google Calender or iCal. You can put each event into a category, and then do things such
as color them by category, or show only certain categories.

There are two ways to organize your categories. First, just have one per file. I prefer this option as it keeps from having too long of a file, and I
find it easier to think of each category as completely independent. The second way would be to use a single file, and have each category in its own
subgroup.

### Begin creating some events

As I've said, at its core, orgmode is an outlining system, so org-mode files tend to (generally) follow this syntax:

    * First level
    ** Second level
    *** Third level
    ** back to second
    * New first level
    ** Second level under second top

So the single `*` is the top-most level, `**` is nested below it, etc.

Calendar events will follow the same structure. Generally, you'll have the top level by a category, and then all events under that category will be in
the second level, but you could add more structure to it by nesting a sub-category with its own events.

Here's some very simple events.

    * Work
    ** Meeting with Bob
    <2013-06-12 Wed 13:00-14:00>
      ** Call with Sally
      <2013-06-14 Fri 3:30pm>

The time stamp should be fairly self-explanatory. The day of the week and time are both completely optional. For time, note that two times separated
by a `-` are the duration of the event, while a single time is simply a start-time (a reminder perhaps). You can enter military time or am/pm. (Note,
for future snippets, I will often ignore the `*` level, just assume they're in a larger file under a top level.)

To make an event spanning multiple days (or a longer alternative to the duration above), use this.

    ** Trip to LA
    <2013-07-10>--<2013-07-15>

Finally, for a recurring event, you can do this.

    ** Team Meeting
    <2013-05-10 Fri 10:00-11:00am +1w>

The `+1w` implies that this event will repeat every week at the same time & date, ad infinitum. The number can be changed, and the usual codes can
replace `w` (e.g. `d` for days, etc) (See below for more advanced repeating events.)

### Viewing your agenda

Now, some editing of your config file (`.emacs` or `init.el`, either in `~` or `~/.emacs.d/`). First, you'll need to add

    <setq org-agenda-files '("~/.emacs.d/org")>

Of course, change that directory as needed. All `.org` files living there will be used for the calendar, assuming an event has a time-stamp.

Now, call `M-x org-agenda` to view your calendar. (Note: You can use `C-h f org-agenda` to see the default key-bindings, and you can use a line like
`(global-set-key (kbd "C-c a") 'org-agenda)` to modify it.)

Hopefully, you now see your weekly schedule! You can visit the [Org manual](http://orgmode.org/manual/Agenda-commands.html) for a full list of key
bindings, but the most useful ones are

-   `f` and `b`: Go forward or backwards in time.
-   `v` followed by `m`, `y` or `w`: View a month, a year, or a week at a time respectively.
-   `.`: Return to today.
-   `Enter`: While your cursor is on an event, open that event in its original file.
-   `f` and `b`: Go forward or backwards in time.
-   `r`: Rebuild the agenda (if you've been editing files).

### Categories

By default, the file-name of your `.org` file are your file-name, so if you named your file `calendar.org`, you might be seeing

      Wednesday  12 June 2013
      calendar:    1:00pm- 2:00pm Meeting with Bob

The `calendar:` tag can be made more informative by use PROPERTIES. For example, taking the sample from above,

    * Work
    :CATEGORY: Work
    ** Meeting with Bob
    <2013-06-12 Wed 13:00-14:00>
      ** Call with Sally
      <2013-06-14 Fri 3:30pm>

Now, the calender would look like

    Wednesday  12 June 2013
    Work:        1:00pm- 2:00pm Meeting with Bob

The `:CATEGORY` will apply to a given event and all below it. So if you have your work file, you can add a second level, for example `** Off-site
Events`, give it a category like `:CATEGORY: Off-site` and then put events below it, `*** An off-site visit`, then even if this is nested in the Work
file, it will have the `Off-site:` category.

### Useful config settings

Here's some settings I find useful. These go in your config file as above.

A week starts on Sunday as opposed to Monday:

    <setq org-agenda-start-on-weekday 0>

Use 12-hour clock instead of 24-hour in agenda view:

    <setq org-agenda-timegrid-use-ampm 1>

By default, the time-grid is only shown today if you have any events, this makes it always show today regardless of events.

    <setq org-agenda-time-grid '((daily today today)
    #("----------------" 0 16 (org-heading t))
    (800 1000 1200 1400 1600 1800 2000)))>

### Some advanced features

#### Color-coding

The following fairly self-explanatory code in your config file will color events. You can use [this page](http://raebear.net/comp/emacscolors.html) to
get a list of colors.  Simply modify the list of `(color-org-header "tag" "color")` to your needs.

          (add-hook 'org-finalize-agenda-hook
          (lambda ()
          (save-excursion
          (color-org-header "Personal:"  "green")
          (color-org-header "Birthdays:" "gold")
          (color-org-header "Work:"      "orange")
          (color-org-header "Off-site:"  "SkyBlue4"))))

          (defun color-org-header (tag col)
          ""
          (interactive)
          (goto-char (point-min))
          (while (re-search-forward tag nil t)
          (add-text-properties (match-beginning 0) (point-at-eol)
          `(face (:foreground ,col)))))

#### Complicated scheduling

You can use diary sexp entries to do more complicated scheduling. There are plenty of places online to see details, for example
[here](http://orgmode.org/worg/org-faq.html#Appointments/Diary), but here's an example to get you started.

          ** 10:00-11:30am Twice weekly!
          <%%(org-class 2013 9 3 2013 12 11 1)>
          <%%(org-class 2013 9 3 2013 12 11 3)>

This says this event is scheduled from 9/3/2013 to 12/11/2013, on every Monday (the final 1 in the first time-stamp) and Wednesday (the final 3 in the
second time-stamp). Note that the time is in the `**` line!

#### Birthdays and Holidays

Without further comment, here's a neat way to have holidays and birthdays in your agenda.

          * Birthday
          #+CATEGORY: Holidays
          %%(org-calendar-holiday)
          #+CATEGORY: Birthdays
          %%(diary-anniversary  9 12 1957) John, %d y.o.
          %%(diary-anniversary  4  3 1962) Sally, %d y.o.

**Future goals**: Auto-removing past events
