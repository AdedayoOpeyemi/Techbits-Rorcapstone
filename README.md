# Techbit

Ruby on Rails Capstone project for Microverse 

The project consists of creating an MVP ready application with functions similar to Twitter. The following functionalities were implemented:

- Users log in only with username (proper authentication was not a requirement).
- Before a user logs in they can only see the Log in/Sign up page.
- When they log in they have full access to the app.
- Users can post tweets.
- Users can follow other users.
- Users can unfollow other users.
- Users can add a profile photo and a profile cover image
- They must upload the images while signing up.
- The app is an MVP of the full product - with the full graphical design, but only basic features that can be extended in the future.

:web The Live Version - [Techbit](https://fast-lake-35378.herokuapp.com)

Design: [Twitter Redesign](https://www.behance.net/gallery/14286087/Twitter-Redesign-of-UI-details), by [Gregoire Vella](https://www.behance.net/gregoirevella)

## Home page

![Homepage](/doc/homepage.png?raw=true "Homepage")

## Profile page

![Profile page](/doc/profilepage.png?raw=true "Profile page")

## Built With

- Ruby (version 2.6.6)
- Ruby on Rails (version 6.0.3.3)

- Gems
  - gem 'pg'
  - gem 'rspec'

## Usage

Clone the repository to your machine and cd into the directory

```
$ git clone https://github.com/adedayoopeyemi/techbit.git
$ cd techbit
$ bundle install
$ rails db:migrate
```

Use the following command to start the rails server then visit: http://localhost:3000 to use the app

```
$ rails s
```

Run RSpec tests

```
$ rails db:migrate RAILS_ENV=test
$ bundle exec rspec
```

## N+1 Problem

In the application, each User has a collection of Followings objects and also a collection of Techbits. The User → Following and the User → Techbit is a one-to-many relationship.
Each User has multiple Techbits they are associated with.

When calling on the list of Techbits for the purpose of presentation, the default approach will be to do the following

Now, when presenting a Techbit information along with information of the authors, the naive implementation would do the following:

```sql
SELECT * FROM techbits WHERE auhtor_id = ?
```

And then for each Techbit:

```sql
SELECT * FROM users WHERE id = ?;
```

In essence, there are multiple calls to the database, a select statement for all the Techbits and then N additional selects to get the author information for each Techbit, where N is the total number of Techbits.

Rails solves this by implementing **Eager Loading** on associations such as this, and example of this in the application is in the `users_controller.rb`

```ruby
def show
  @techbits = Techbit.where('author_id in (?)', (
      logged_user.followed_ids + [logged_user.id]
    ).uniq)
      .includes(:author)
      .order(created_at: :desc)
  # ...
end
```

## Authors

👤 **Opeyemi Oyelesi**

- Github: [@AdedayoOpeyemi](https://github.com/adedayopeyemi)
- Linkedin: [Opeyemi Oyelesi](https://linkedin.com/in/opeyemioyelesi)

## 🤝 Contributing

To make ontributions, raise issues and requests features:

Feel free to check the [issues page](https://github.com/adedayoopeyemi/techbit/issues).

## Acknowledgments

- [Microverse](https://www.microverse.org/)
- [Gregoire Vella](https://www.behance.net/gregoirevella)
