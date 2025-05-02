# SmartCalc - Comprehensive Calculator Suite

SmartCalc is a modern, responsive calculator website that provides a wide range of calculators for various purposes. From basic arithmetic to specialized financial, scientific, medical, and construction calculators, SmartCalc offers an intuitive and user-friendly interface for all your calculation needs.

![SmartCalc Screenshot](screenshot.png)

## Features

- **Multiple Calculator Types**:
  - Basic Arithmetic (Addition, Subtraction, Multiplication, Division)
  - Scientific Calculator with Advanced Functions
  - Graphing Calculator with Visualization
  - Financial Calculators (Compound Interest, Retirement, Savings Goal)
  - Construction Calculators (Concrete, Brick, Paint, Plaster)
  - Medical Dosage Calculators
  - Conversion Calculators (Length, Weight, Temperature, Currency)
  - GST Calculator (Add/Remove)
  - Profit/Loss Calculator
  - Age Calculator
  - Programmable Calculators with Custom Formulas
  - Printing Calculators for Business Needs

- **User Experience**:
  - Clean, Minimalist Interface
  - Real-time Calculations Without Page Reloads
  - Responsive Design for All Devices
  - Dark Mode Support
  - Comprehensive Educational "How It Works" Sections

- **Technical Highlights**:
  - React-based Frontend with Wouter for Routing
  - Shadcn UI Components for Modern Styling
  - TailwindCSS for Responsive Design
  - Node.js Express Backend (Optional)
  - PostgreSQL Database Support (Optional)
  - AI-powered Calculation Suggestions (Optional with API Key)

## Getting Started

### Prerequisites

- Node.js (version 16 or higher)
- NPM or Yarn
- PostgreSQL (optional for backend features)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/smartcalc.git
   cd smartcalc
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```

4. The application will be available at `http://localhost:3000`

## Deployment

For detailed deployment instructions, please refer to the [Deployment Guide](DEPLOYMENT_GUIDE.md).

## Configuration

### Environment Variables

For backend functionality (optional), create a `.env` file with:

```
DATABASE_URL=your_postgresql_connection_string
ANTHROPIC_API_KEY=your_anthropic_api_key (optional for AI suggestions)
```

## Project Structure

```
smartcalc/
├── client/             # Frontend code
│   ├── src/            # React components and hooks
│   │   ├── components/ # UI components and calculators
│   │   ├── hooks/      # Custom React hooks
│   │   ├── lib/        # Utility functions
│   │   ├── pages/      # Page components
│   ├── index.html      # HTML entry point
├── server/             # Backend code (Express)
├── db/                 # Database configuration
├── shared/             # Shared types and schemas
├── public/             # Static assets
└── DEPLOYMENT_GUIDE.md # Deployment instructions
```

## Customization

### Adding New Calculators

1. Create a new calculator component in `client/src/components/`
2. Add a new page component in `client/src/pages/`
3. Register the new route in `client/src/App.tsx`
4. Update the navigation menu in `client/src/components/Navbar.tsx`

### Styling

- The project uses TailwindCSS for styling
- Theme colors can be customized in `tailwind.config.ts`
- Global styles are in `client/src/index.css`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- All calculator images and icons are either created by our team or sourced from open-source libraries
- Thanks to the creators of React, TailwindCSS, and all the other open-source libraries used in this project