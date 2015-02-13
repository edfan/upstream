# Setup on OSX

1. Clone dev branch

2. Install Homebrew and RVM

        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew doctor

        brew install gpg2
        gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
        \curl -sSL https://get.rvm.io | bash -s stable

3. Install PostgreSQL

        brew install postgres
        mkdir -p ~/Library/LaunchAgents
        ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
        launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
        cat /etc/paths

    Check that the first line is /usr/local/bin. If it isn't, use `sudo nano /etc/paths` and change it. Then *reboot*.

4. Create database

    Check that `which psql` returns /usr/local/bin/psql. If it does,

        createdb `whoami`

    Check that `psql` is successful. Once it is, you can exit via \q or Ctrl+D.

5. Install Rubinius (multithreaded Ruby)

        rvm install rbx-2.2.10

    This takes a while (10 minutes or so). If you get an error about LLVM, run `brew install llvm` Once done,

        rvm --default rbx-2.2.10

6. Install gems

    Make sure you're in the root directory.

        gem install bundler
        bundle install

7. Set up database

        rake db:create
        rake db:migrate

8. Ready to go!

    Run `rails server` to start the server. It's accessible at http://localhost:3000. Ctrl+C to stop the server.

# When pulling updates

        bundle install
        rake db:migrate

    If we upgrade Rubinius (unlikely) you can install the new version with `rvm install rbx-(version)`.
