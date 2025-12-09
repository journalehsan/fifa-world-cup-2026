#!/usr/bin/env bash

# World Cup Hub Management Script
# Usage: ./manage.sh [setup|start|stop|restart]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
}

# Check if Node.js is installed
check_node() {
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js first."
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install npm first."
        exit 1
    fi
}

# Check if Rust/Cargo is installed
check_rust() {
    if ! command -v cargo &> /dev/null; then
        print_error "Rust/Cargo is not installed. Please install Rust first."
        exit 1
    fi
}

# Setup function
setup() {
    print_status "Setting up World Cup Hub development environment..."
    
    # Check dependencies
    print_status "Checking dependencies..."
    check_docker
    check_node
    check_rust
    
    # Start PostgreSQL container
    print_status "Starting PostgreSQL container..."
    if docker compose version &> /dev/null; then
        docker compose up -d postgres
    else
        docker-compose up -d postgres
    fi
    
    # Wait for PostgreSQL to be ready
    print_status "Waiting for PostgreSQL to be ready..."
    sleep 5
    
    # Install frontend dependencies
    print_status "Installing frontend dependencies..."
    npm install
    
    # Create .env file if it doesn't exist
    if [ ! -f .env ]; then
        print_status "Creating .env file..."
        cat > .env << EOF
# Database Configuration
DATABASE_URL=postgres://worldcup_user:worldcup_pass@localhost:5432/worldcup_db

# Server Configuration
HOST=127.0.0.1
PORT=8080

# Environment
RUST_LOG=info
EOF
        print_success ".env file created with default configuration."
    fi
    
    # Build frontend assets
    print_status "Building frontend assets..."
    npm run build
    
    print_success "Setup completed successfully!"
    print_status "You can now run './manage.sh start' to start the development server."
}

# Start function
start() {
    print_status "Starting World Cup Hub development server..."
    
    # Check dependencies
    check_docker
    check_node
    check_rust
    
    # Start PostgreSQL if not running
    if ! docker ps | grep -q worldcup_postgres; then
        print_status "Starting PostgreSQL container..."
        if docker compose version &> /dev/null; then
            docker compose up -d postgres
        else
            docker-compose up -d postgres
        fi
        sleep 3
    fi
    
    # Build frontend assets (CSS + JS)
    print_status "Building frontend assets..."
    npm run build
    
    # Start Rust server (serves HTML + static assets)
    print_status "Starting Rust web server..."
    print_success "World Cup Hub is running at http://127.0.0.1:8080"
    print_warning "Press Ctrl+C to stop server"
    print_warning "Full HTML server-side rendering with SEO-friendly URLs"
    
    # Start Rust server
    cargo run
    
    # Cleanup frontend process on exit
    if [ -f .frontend_pid ]; then
        kill $(cat .frontend_pid) 2>/dev/null || true
        rm .frontend_pid
    fi
}

# Stop function
stop() {
    print_status "Stopping World Cup Hub development server..."
    
    # Stop frontend process
    if [ -f .frontend_pid ]; then
        print_status "Stopping frontend process..."
        kill $(cat .frontend_pid) 2>/dev/null || true
        rm .frontend_pid
    fi
    
    # Kill any remaining npm processes
    pkill -f "npm run dev" 2>/dev/null || true
    
    # Stop Rust server (if running in background)
    pkill -f "cargo run" 2>/dev/null || true
    
    # Stop PostgreSQL container
    print_status "Stopping PostgreSQL container..."
    if docker ps | grep -q worldcup_postgres; then
        if docker compose version &> /dev/null; then
            docker compose stop postgres
        else
            docker-compose stop postgres
        fi
    fi
    
    print_success "All services stopped."
}

# Restart function
restart() {
    print_status "Restarting World Cup Hub development server..."
    stop
    sleep 2
    start
}

# Help function
help() {
    echo "World Cup Hub Management Script"
    echo ""
    echo "Usage: ./manage.sh [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  setup    - Initialize the development environment"
    echo "  start    - Start the development server"
    echo "  stop     - Stop all running services"
    echo "  restart  - Restart the development server"
    echo "  help     - Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./manage.sh setup    # First-time setup"
    echo "  ./manage.sh start    # Start development server"
    echo "  ./manage.sh stop     # Stop all services"
}

# Main script logic
case "$1" in
    setup)
        setup
        ;;
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    help|--help|-h)
        help
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        help
        exit 1
        ;;
esac