## Form App

### CRUD Operations

This Phoenix/Elixir application implements basic CRUD (Create, Read, Update, Delete) operations for managing resources.

#### Features

- **Create**: Allows users to create new resources.
- **Read**: Enables users to view a list of resources and details of individual resources.
- **Update**: Provides functionality to edit existing resources.
- **Delete**: Allows users to remove resources.

#### Implementation Details

- **Controllers**: Implemented CRUD operations in the `ResourceController`.
  - `new` action for displaying the form to create a new resource.
  - `create` action for saving a new resource to the database.
  - `edit` action for displaying the form to update an existing resource.
  - `update` action for saving changes to an existing resource.
  - `delete` action for removing a resource.

- **Views**: Created view templates for resource management.
  - `new.html.eex`: Form for creating a new resource.
  - `edit.html.eex`: Form for updating an existing resource.
  - `show.html.eex`: Display details of a resource.
  - `index.html.eex`: List all resources.

- **Routes**: Updated `router.ex` to include paths for CRUD operations.
  - `GET /resources/new` - Show form for creating a new resource.
  - `POST /resources` - Create a new resource.
  - `GET /resources/:id/edit` - Show form for editing a resource.
  - `PUT/PATCH /resources/:id` - Update a resource.
  - `DELETE /resources/:id` - Delete a resource.

- **Schema & Changesets**: Updated the `Resource` schema and changesets to handle validations and data integrity.
  - Added validation for required fields and constraints.
  - Implemented necessary changesets to manage data changes.

- **Database Migrations**: Added migrations to create and manage the resource table schema.
