Hosting a git repo on UM Servers
# Hosting a git repo on UM Servers

This will host the bare repo on the UM's AFS space. It can be cloned on the server or locally.

Current limitations:

Pulling and pushing requires a password (UM Servers don't allow logging in with SSH keys).

Other users cannot clone this repository.

-   If you really need to share, you can push the up-to-date working
    directory to Github or others.

1.  Choose what server you want to access the AFS from:
    -   SCS servers - easy, but being retired soon.
    -   login servers - Equally easy, probably the best current option.
        Wouldn\'t be surprised if they\'re retired soon too.
    -   greatlakes servers - Most modern, most up-to-date software, but
        requires 2-factor on each login.

2.  If using SCS or login, `git` is quite old. You\'ll need to run

        scl enable rh-git29 httpd24 -- git


    instead of just `git`. If you put the following line in your .zshrc
    (or the bash equivalent), you can alias `git` to this.

        alias git='scl enable rh-git29 httpd24 -- git'


    Now using `git` will run the above, whereas `\git` will ignore the
    alias and run the old version.

    Confirm this worked with `git --version` and `\git --version`. (You
    may need to re-login first.)

3.  Next, you\'ll do a bare-repo clone on the server:

        git clone --bare [repo address]


    If you\'ve never pushed your git repo up to a server you can clone
    from, or you are starting a new repo, instead you can init the repo
    and then add it as the remote.

    On the server, create a directory called \"\[repo name\].git\".
    Within it, run:

        git init --bare


    Finally, locally, run one of (depending on choice of server):

        git remote add origin [uniqname]@scs.dsc.umich.edu:[path-to-bare-repo].git
        git remote add origin [uniqname]@login.itd.umich.edu:[path-to-bare-repo].git
        git remote add origin [uniqname]@greatlakes.arc.ts.umich.edu:/afs/umich.edu/user/u/n/uniqname/[path-to-bare-repo].git


4.  You can now push and pull from the server.
