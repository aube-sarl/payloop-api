<img width="1271" height="1276" alt="payloop" src="https://github.com/user-attachments/assets/23f36e82-3031-41a5-86fa-5ad8a4d0c066" />

# PayLoop

PayLoop is a cross-border payment system that integrates with **Airtel Money, MTN Mobile Money, M-Pesa, and other mobile money APIs**.  
It enables users and businesses to send and receive money seamlessly across East African countries.  

## 🚀 Features
- Integration with multiple mobile money providers (Airtel Money, MTN, M-Pesa).
- Secure authentication and transaction signing.
- Currency conversion and transaction fees handling.
- Audit logging and compliance checks.
- Scalable API for third-party integrations.

## 🛠️ Tech Stack
- Ruby on Rails (API backend)
- PostgreSQL
- Redis & Sidekiq (background jobs)
- Docker
- JWT authentication & encryption
- RSpec (tests)

## ⚙️ Setup & Run
```bash
# Install dependencies
bundle install

# Setup database
rails db:create db:migrate db:seed

# Run background jobs
bundle exec sidekiq

# Run server
rails s
