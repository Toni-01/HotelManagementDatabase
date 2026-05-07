# Hotel Management System - Database Schema

A comprehensive SQL Server database solution for managing hotel operations, including room inventory, client reservations, employee scheduling, and financial tracking. This project demonstrates advanced SQL techniques including **Relational Mapping**, **Data Integrity Constraints**, **Complex Views**, and **Programmability** (Stored Procedures & Functions).

## 🚀 Key Features

* **Robust Data Integrity:** Implements complex business rules using `CHECK` constraints and `UNIQUE` indexes to prevent invalid data.
* **Automated Validation:** Features custom functions to prevent overlapping room bookings.
* **Financial Tracking:** Manages multi-method payments and automated total amount calculations.
* **Operational Intelligence:** Includes logging for room status changes to maintain an audit trail.
* **Advanced Analytics:** Provides detailed views for room occupancy statistics and client spending habits.

## 🏗️ Database Architecture

### Core Tables
* **Rooms:** Manages inventory with constraints on room types (`single`, `double`, `suite`) and status.
* **Clients:** Stores guest information with integrated email and phone format validation.
* **Employees:** Tracks staff details across departments like Reception, Spa, and Kitchen.
* **Services:** Catalog of hotel amenities (e.g., Spa, Gym) with department-based pricing.

### Transactional Tables
* **Reservations:** The central link between clients and rooms, utilizing a custom function to ensure availability.
* **ServiceBookings:** Tracks additional amenities used during a stay.
* **Payments:** Records financial transactions with support for various payment methods.

## 💻 Programmability & Analytics

### Stored Procedures
* **`sp_GetClientDetailedReport`**: Generates a comprehensive performance report for a specific client, calculating total spend, average daily spend, and identifying their favorite room type using cursors and temporary tables.

### Functions
* **`CalculateClientLoyaltyPoints`**: A scalar function that calculates reward points based on nights stayed and spending tiers.
* **`fn_CheckOverlap`**: A critical logical check used within table constraints to prevent double-booking rooms.

### Views
* **`vw_RoomOccupancyStats`**: Aggregates booking data to show revenue and popularity by room type.
* **`ClientReservationSummary`**: Consolidates client history, total nights booked, and even lists specific services used via XML path concatenation.

## 🛠️ Installation & Setup

1.  Clone the repository to your local machine.
2.  Open **SQL Server Management Studio (SSMS)** or **Visual Studio**.
3.  Execute the scripts in the following order to handle dependencies:
    * `Rooms.sql`, `Clients.sql`, `Employees.sql`, `Services.sql`
    * `fn_CheckOverlap.sql`
    * `Reservations.sql`
    * `Payments.sql`, `ServiceBookings.sql`, `RoomStatusLog.sql`
    * Remaining Functions, Procedures, and Views.
