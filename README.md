# constantize

## Description

Simple, dynamic and efficient activerecord model constants.

Ever wanted to be able to be able to do something like:

<pre>
case buoy.buoy_type
when BuoyType::NOAA
..
when BuoyType::SCRIPPS
..
end
</pre>

or

<pre>
User.create(:login => :foo, :user_status => UserStatus::ACTIVE)
</pre>

but weren't sure the best / most efficient way to implement?

One way would be to do something like:

    class BuoyType < ActiveRecord::Base
      NOAA = find_by_name('noaa')
      ..
    end

which would work but in a production environment could result in a non-trivial amount
of unecessary db queries.

Another way would be to dynamically create the constants for all the rows in the given
table at rails start.  However, for models w/hundreds of rows, e.g., Country, City,
this wouldn't be very efficient either.

This gem minimizes the db calls by memoizing the finder that is used to look up the constant
values.  So, it depends on your app server but only the first refernece to a given constant
should require a db query (see the code and specs for more details).

## Install

### Manual Install

Standard gem install:

<pre>
gem install constantize
</pre>

After installing the gem you would need to require it:

<pre>
require 'constantize'
</pre>

### Rails 2.x / No Bundler

In a Rails 2.x project you can add this to your environment.rb:

<pre>
config.gem 'constantize'
</pre>

followed by:

<pre>
rake gems:install
</pre>

### Rails 3.x / Bundler

In Rails 3.x add this to your Gemfile:

<pre>
gem 'constantize'
</pre>

followed by:

<pre>
bundle install
</pre>

## Usage

In the model that you will be "constantizing" simply add the following to the top:

constantize :key

where :key is the name of the field that will be used to build the finder.

E.g., 

    class AccountStatus < ActiveRecord::Base
      constantize :name
      ..
    end

this would assume that your account_statuses table looked something like:

    +----+---------+
    | id | name    |
    +----+---------+
    |  1 | active  |
    |    ..        |
    +----+---------+

if your table used a different field, say :title, rather than :name:

    +----+---------+
    | id | title   |
    +----+---------+
    |  1 | active  |
    |    ..        |
    +----+---------+

then your model definition would look like:

    class AccountStatus < ActiveRecord::Base
      constantize :title
      ..
    end

Finally, if you wanted only the :id to be returned from the constant call (rather than
the entire model) you could do:


    class AccountStatus < ActiveRecord::Base
      constantize :name, :id
      ..
    end

and your call to AccountStatus::ACTIVE would return only the interger :id value (1 in this
case).

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Adam Weller. See LICENSE for details.

