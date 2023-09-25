# Pizza Ordering API

A simple pizza ordering program.

## About the Project
- Ruby 3.1.2
- Rails 7.0.8
- Database Sqlite

## Getting Started
```bash
git clone https://github.com/htoomyatag/billplz.git
cd billplz
bundle install

rake db:create
rake db:migrate
rake db:seed

rails server
```
## Usage
Open new terminal
```bash
curl -X POST -H "Content-Type: application/json" -d '{
  "orders": [
    {
      "pizza_size_id": 1,
      "topping_ids": [1, 3]
    },
    {
      "pizza_size_id": 2,
      "topping_ids": [2, 3]
    },
    {
      "pizza_size_id": 3,
      "topping_ids": [3]
    }
  ]
}' http://localhost:3000/pizza_orders
```
## Testing
```bash
rails test
```
