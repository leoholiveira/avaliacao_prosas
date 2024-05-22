
# Ruby on Rails Test Umanni

This project is a Ruby on Rails that leverages the Devise framework for authentication for secure user authentication.

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`DB_USER`
`DB_PASS`
`DB_HOST`
`DB_PORT`
`DB_NAME`

## Environment Setup

Initialize docker:

```bash
  docker-compose build
  docker-compose up
```

Ensure you have Ruby and Rails installed on your system. Install project dependencies using the following command:

```bash
  bundle install
```

Additionally, configure the database by running the following commands:

```bash
  rails db:create
  rails db:migrate
```

### Start the project:

```bash
  rails s
```

### Endpoints

- POST /projects (create projects)
```bash
  Content-Type: application/json
  {
    "project": {
      "name": "Project Name",
      "evaluations_attributes": [
        {
          "grades_attributes": [
            { "score": 5.0, "criterion_id": 1 },
            { "score": 3.5, "criterion_id": 2 }
          ]
        }
      ]
    }
  }
```

- GET /projects?page=1&per_page=25 (list projects)

- POST /criterions (create criterion)
```bash
  Content-Type: application/json
  {
    "criterion": {
      "weight": 2.5
    }
  }
```

### Run test:

```bash
  rspec
```

## Contributions

Contributions are always welcome!

## Support

For support, email contatos_leo@hotmail.com.

## Tech Stack

**Server:** Ruby, Rspec, Docker.

## License

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

## Authors

- [@leoholiveira](https://github.com/leoholiveira)