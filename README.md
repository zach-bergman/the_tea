Certainly! Here’s a cleaner version of your README with dropdown arrows for the endpoints:

---

# The Tea

Welcome to **The Tea**, a Rails application developed as part of the Turing School's Mod 4 Take-Home Challenge. This project is designed to showcase a range of skills, including API exposure, custom endpoints, and testing, while demonstrating the ability to build a RESTful API with clean, maintainable code.

## Table of Contents

- [Features](#features)
- [Project Overview](#project-overview)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Usage](#usage)
- [Endpoints](#endpoints)
- [Running Tests](#running-tests)

## Features

- **API Consumption**: Integrates with an external tea API to provide information on various tea types.
- **Custom Endpoints**: Implements custom API endpoints for managing tea subscriptions.
- **RESTful API Design**: Follows best practices for RESTful API design, ensuring intuitive and standardized routes.
- **Robust Testing**: Comprehensive test coverage using RSpec, focusing on unit, feature, and request specs.

## Project Overview

The goal of this project is to build a back-end API that handles tea subscription management for customers. Users can subscribe to different types of teas and manage their subscriptions (create, cancel, view all).

## Getting Started

Follow these instructions to set up the project on your local machine for development and testing.

### Prerequisites

- **Ruby version**: `2.7.4` or later
- **Rails version**: `6.1.4` or later
- **PostgreSQL**: Ensure you have PostgreSQL installed and running

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/zach-bergman/the_tea.git
    cd the_tea
    ```

2. Install the required gems:

    ```bash
    bundle install
    ```

3. Set up the database:

    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

### Configuration

Ensure you have set up any necessary environment variables:

- `DATABASE_URL`: Database connection URL for PostgreSQL

## Usage

Start the Rails server:

```bash
rails server
```

Navigate to `http://localhost:3000` in your web browser to interact with the application, or use a tool like Postman.

## API Endpoints

### 1. POST /api/v1/customer_subscriptions
- **Endpoint**: `/api/v1/customer_subscriptions`
- **Method**: `POST`
- **Parameters**: 
  - `customer_id` (required)
  - `subscription_id` (required)

#### Example Request

```http
POST /api/v1/customer_subscriptions
Content-Type: application/json

{
  "customer_id": "1",
  "subscription_id": "1"
}
```

#### Example Response

```json
{
    "data": {
        "id": "2",
        "type": "customer_subscription",
        "attributes": {
            "status": "active",
            "title": "title",
            "price": 1,
            "frequency": 1
        },
        "relationships": {
            "customer": {
                "data": {
                    "id": "1",
                    "type": "customer"
                }
            },
            "subscription": {
                "data": {
                    "id": "1",
                    "type": "subscription"
                }
            }
        }
    }
}
```

### 2. PATCH /api/v1/customer_subscriptions/:customer_subscription_id

- **Endpoint**: `/api/v1/customer_subscriptions/:customer_subscription_id`
- **Method**: `PATCH`
- **Parameters**:
  - `status` (required): The new status to update the customer_subscription record.

#### Example Request

```http
PATCH /api/v1/customer_subscriptions/:customer_subscription_id
Content-Type: application/json

{
  "status": "cancelled"
}
```

#### Example Response

```json
{
    "data": {
        "id": "1",
        "type": "customer_subscription",
        "attributes": {
            "status": "cancelled",
            "title": "title",
            "price": 1,
            "frequency": 1
        },
        "relationships": {
            "customer": {
                "data": {
                    "id": "1",
                    "type": "customer"
                }
            },
            "subscription": {
                "data": {
                    "id": "1",
                    "type": "subscription"
                }
            }
        }
    }
}
```

### 3. GET /api/v1/customer_subscriptions/:customer_id

#### Get all subscriptions(active or cancelled) for a given customer

- **Endpoint**: `/api/v1/customer_subscriptions/:customer_id?status=active`
- **Method**: `GET`
- **Parameters**:
  - `customer_id` (required): The user's email address.
  - `status=`: `active` or `cancelled`.

#### Example Request

```http
GET /api/v1/customer_subscriptions/:customer_id?status=active
Content-Type: application/json
```

#### Example Response

```json
{
    "data": [
        {
            "id": "2",
            "type": "customer_subscription",
            "attributes": {
                "status": "active",
                "title": "title",
                "price": 1,
                "frequency": 1
            },
            "relationships": {
                "customer": {
                    "data": {
                        "id": "1",
                        "type": "customer"
                    }
                },
                "subscription": {
                    "data": {
                        "id": "1",
                        "type": "subscription"
                    }
                }
            }
        }
    ]
}
```

## Running Tests

To run the test suite, use the following command:

```bash
bundle exec rspec
```
