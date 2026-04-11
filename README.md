# 📋 Complaint Management System

A full-stack web application that allows users to register complaints and enables administrators to track, update, and resolve them efficiently.

---

## 🚀 Features

### 👤 User Features
- Register and log in securely
- Submit new complaints with title, description, and category
- Upload attachments/screenshots (optional)
- Track real-time status of submitted complaints
- Receive email/in-app notifications on status updates
- View complaint history

### 🛡️ Admin Features
- Secure admin dashboard
- View all complaints with filters (status, category, date, priority)
- Assign complaints to specific staff/departments
- Update complaint status: `Pending → In Progress → Resolved → Closed`
- Add internal notes or responses visible to the user
- Generate reports and analytics
- Manage users and roles

---

## 🧱 Tech Stack

| Layer       | Technology                        |
|-------------|-----------------------------------|
| Frontend    | React.js / HTML + CSS + JS        |
| Backend     | Node.js + Express.js              |
| Database    | MongoDB / PostgreSQL               |
| Auth        | JWT (JSON Web Tokens)             |
| File Upload | Multer + Cloudinary (optional)    |
| Email       | Nodemailer / SendGrid             |
| Deployment  | Docker + AWS / Heroku / Vercel    |

> You may adapt the stack as per your project requirements.

---

## 📁 Project Structure

```
complaint-management-system/
│
├── client/                     # Frontend (React or HTML)
│   ├── public/
│   └── src/
│       ├── components/
│       │   ├── Auth/           # Login, Register forms
│       │   ├── User/           # Submit, Track complaints
│       │   └── Admin/          # Dashboard, Complaint list
│       ├── pages/
│       ├── services/           # API calls (axios)
│       └── App.js
│
├── server/                     # Backend (Node.js)
│   ├── config/
│   │   └── db.js               # Database connection
│   ├── controllers/
│   │   ├── authController.js
│   │   ├── complaintController.js
│   │   └── adminController.js
│   ├── middlewares/
│   │   ├── authMiddleware.js   # JWT verification
│   │   └── roleMiddleware.js   # Admin role check
│   ├── models/
│   │   ├── User.js
│   │   └── Complaint.js
│   ├── routes/
│   │   ├── authRoutes.js
│   │   ├── complaintRoutes.js
│   │   └── adminRoutes.js
│   └── server.js
│
├── .env                        # Environment variables
├── .gitignore
├── package.json
└── README.md
```

---

## ⚙️ Installation & Setup

### Prerequisites
- Node.js v16+
- MongoDB or PostgreSQL installed and running
- npm or yarn

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/complaint-management-system.git
cd complaint-management-system
```

### 2. Install Dependencies
```bash
# Install server dependencies
cd server
npm install

# Install client dependencies
cd ../client
npm install
```

### 3. Configure Environment Variables
Create a `.env` file inside the `server/` directory:
```env
PORT=5000
MONGO_URI=mongodb://localhost:27017/complaint_db
JWT_SECRET=your_jwt_secret_key
EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_email_password
CLOUDINARY_URL=your_cloudinary_url   # Optional for file uploads
```

### 4. Run the Application

#### Development Mode
```bash
# Start backend
cd server
npm run dev

# Start frontend (in a new terminal)
cd client
npm start
```

#### Production Mode
```bash
# Build frontend
cd client
npm run build

# Start server
cd ../server
npm start
```

---

## 🔐 API Endpoints

### Auth Routes
| Method | Endpoint              | Description           | Access  |
|--------|-----------------------|-----------------------|---------|
| POST   | `/api/auth/register`  | Register new user     | Public  |
| POST   | `/api/auth/login`     | User login            | Public  |
| GET    | `/api/auth/profile`   | Get logged-in profile | Private |

### Complaint Routes (User)
| Method | Endpoint                    | Description              | Access        |
|--------|-----------------------------|--------------------------|---------------|
| POST   | `/api/complaints`           | Submit a new complaint   | User/Admin    |
| GET    | `/api/complaints/my`        | Get my complaints        | User          |
| GET    | `/api/complaints/:id`       | Get complaint by ID      | User/Admin    |

### Admin Routes
| Method | Endpoint                         | Description                    | Access |
|--------|----------------------------------|--------------------------------|--------|
| GET    | `/api/admin/complaints`          | Get all complaints             | Admin  |
| PUT    | `/api/admin/complaints/:id`      | Update status/assign/respond   | Admin  |
| DELETE | `/api/admin/complaints/:id`      | Delete a complaint             | Admin  |
| GET    | `/api/admin/users`               | Get all users                  | Admin  |

---

## 🔄 Complaint Lifecycle

```
User Submits Complaint
        │
        ▼
   [Pending] ──────────────────────────────────┐
        │                                       │
        ▼ (Admin assigns/acknowledges)          │
  [In Progress] ─────────────────────────────┐ │
        │                                     │ │
        ▼ (Admin resolves)                    │ │
   [Resolved] ──(User unsatisfied)──► [Reopened]│
        │                                       │
        ▼ (Admin closes)                        │
    [Closed] ◄──────────────────────────────────┘
```

---

## 👥 User Roles

| Role  | Permissions                                              |
|-------|----------------------------------------------------------|
| User  | Register, login, submit complaints, view own complaints  |
| Admin | All user permissions + manage/update/delete all complaints, manage users |

---

## 📊 Admin Dashboard Overview

- **Total Complaints** — Count by status (Pending, In Progress, Resolved)
- **Recent Complaints** — Latest submissions table
- **Category Breakdown** — Pie/Bar chart by complaint type
- **Response Time Metrics** — Average resolution time
- **User Activity** — Most active users / departments

---

## 📬 Notifications

- **Email Notification** sent to user when:
    - Complaint is received (confirmation)
    - Status is updated by admin
    - Complaint is resolved or closed
- **In-App Notification** badge on the user dashboard

---

## 🧪 Running Tests

```bash
# Backend unit/integration tests
cd server
npm test

# Frontend tests
cd client
npm test
```

---

## 🐳 Docker Setup (Optional)

```bash
# Build and run with Docker Compose
docker-compose up --build
```

Make sure your `docker-compose.yml` includes services for `client`, `server`, and `mongodb`.

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 📞 Contact

For questions, issues, or suggestions:
- 📧 Email: your-email@example.com
- 🐛 Issues: [GitHub Issues](https://github.com/your-username/complaint-management-system/issues)

---

> ⭐ If you find this project helpful, please give it a star on GitHub!