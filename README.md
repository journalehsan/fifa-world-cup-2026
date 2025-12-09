# World Cup 2026 Hub

Your ultimate destination for FIFA World Cup 2026 - News, Teams, Players, Match Schedules, Venues, History Wiki and more.

## Tech Stack

- **Backend**: Rust + Actix Web + Askama templates
- **Frontend**: Vite + Tailwind CSS + Alpine.js
- **Database**: PostgreSQL (via Docker)
- **Deployment**: Docker Compose

## Quick Start

### Prerequisites

Make sure you have the following installed:
- [Rust](https://rustup.rs/) (latest stable)
- [Node.js](https://nodejs.org/) (v18+)
- [Docker](https://www.docker.com/) & Docker Compose
- [npm](https://www.npmjs.com/) (comes with Node.js)

### Setup & Run

1. **First-time setup**:
   ```bash
   ./manage.sh setup
   ```

2. **Start development server**:
   ```bash
   ./manage.sh start
   ```

3. **Visit the site**:
   Open http://127.0.0.1:8080 in your browser

### Management Commands

- `./manage.sh setup` - Initialize development environment
- `./manage.sh start` - Start development server
- `./manage.sh stop` - Stop all services
- `./manage.sh restart` - Restart development server
- `./manage.sh help` - Show help message

## Architecture

This project uses **traditional server-side rendering** with modern asset bundling:

- **Backend (Port 8080)**: Rust Actix + Askama serves full HTML pages
- **Asset Building**: Vite bundles Tailwind CSS and Alpine.js for production
- **Database**: PostgreSQL runs in Docker with persistent data
- **SEO Friendly**: Full HTML server-side rendering for search engines

This setup provides:
- 🏆 **SEO Optimized** - Server-side rendered HTML for search engines
- ⚡ **Fast Performance** - Rust backend with optimized asset serving
- 🎨 **Modern Assets** - Tailwind CSS + Alpine.js bundled by Vite
- 🔧 **Simple Architecture** - Clear separation of concerns

## Development Workflow

### Asset Development

The frontend assets are built using Vite:

```bash
# Install dependencies
npm install

# Build assets (CSS + JS)
npm run build

# Watch assets during development (optional)
npm run dev
```

Asset files are located in:
- `src/main.css` - Tailwind CSS entry point
- `src/main.js` - JavaScript with Alpine.js
- `templates/` - Askama HTML templates
- `public/assets/` - Built CSS and JS files

### Backend Development

The Rust backend serves templates and static files:

```bash
# Run the server
cargo run

# Build for release
cargo build --release
```

Backend structure:
- `src/main.rs` - Main application entry point
- `src/routes/` - Route handlers
- `src/templates/` - Template structs

### Database

PostgreSQL runs in Docker with persistent data:

```bash
# Start database only
docker compose up -d postgres

# Connect to database
psql -h localhost -p 5432 -U worldcup_user -d worldcup_db
```

Database configuration is in `.env`:
```
DATABASE_URL=postgres://worldcup_user:worldcup_pass@localhost:5432/worldcup_db
```

## Project Structure

```
├── src/
│   ├── main.rs              # Main application
│   ├── routes/
│   │   ├── mod.rs          # Route module
│   │   └── home.rs         # Home page handler
│   └── templates/
│       └── mod.rs          # Template structs
├── templates/
│   ├── base.html            # Base layout
│   └── home.html           # Home page template
├── src/                   # Frontend source
│   ├── main.css            # Tailwind CSS
│   └── main.js            # Alpine.js
├── public/                # Built frontend assets
├── Cargo.toml             # Rust dependencies
├── package.json           # Node.js dependencies
├── vite.config.js         # Vite configuration
├── tailwind.config.js     # Tailwind configuration
├── docker-compose.yml     # PostgreSQL setup
├── .env                  # Environment variables
└── manage.sh             # Development management script
```

## Features

- 🏠 **Home Page** - Landing page with tournament overview
- 📱 **Responsive Design** - Works on all devices
- 🌙 **Dark Mode** - Toggle between light/dark themes
- ⚡ **Fast Performance** - Rust backend + optimized frontend
- 🎨 **Modern UI** - Tailwind CSS with custom FIFA theme
- 🔧 **Hot Reload** - Frontend changes update automatically
- 🐳 **Docker Support** - Easy database setup

## Environment Variables

Key environment variables in `.env`:

```bash
# Database
DATABASE_URL=postgres://worldcup_user:worldcup_pass@localhost:5432/worldcup_db

# Server
HOST=127.0.0.1
PORT=8080

# Logging
RUST_LOG=info
```

## Production Deployment

For production deployment:

1. Build frontend assets:
   ```bash
   npm run build
   ```

2. Build Rust binary:
   ```bash
   cargo build --release
   ```

3. Set up production database:
   ```bash
   docker compose -f docker-compose.prod.yml up -d postgres
   ```

4. Run the application:
   ```bash
   ./target/release/worldcup_site
   ```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `./manage.sh start`
5. Submit a pull request

## License

This project is not affiliated with FIFA. All rights reserved to respective owners.

---

**Note**: This is a demonstration project for the FIFA World Cup 2026. All team data, schedules, and information should be verified from official sources.