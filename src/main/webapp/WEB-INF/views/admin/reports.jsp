<!DOCTYPE html>
<html>
<head>
    <title>Reports Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        canvas {
            max-height: 250px !important;
        }
    </style>
</head>
<body>

<h2>Reports Dashboard</h2>

<!-- BUTTONS -->
<button onclick="openFilter()">Get Report</button>
<button id="downloadBtn" disabled onclick="downloadReport()">Download Excel</button>

<!-- DATE FILTER -->
<div id="filterBox" style="display:none; margin-top:10px;">
    From: <input type="date" id="fromDate" onchange="checkDates()">
    To: <input type="date" id="toDate" onchange="checkDates()">
    <button onclick="fetchReport()">Submit</button>
</div>

<hr>

<div class="container mt-4">

    <!-- TOP ROW -->
    <div class="row">
        <div class="col-md-6">
            <div class="card p-3 shadow-sm">
                <h5>Complaint Status</h5>
                <canvas id="pieChart"></canvas>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card p-3 shadow-sm">
                <h5>Category-wise Complaints</h5>
                <canvas id="barChart"></canvas>
            </div>
        </div>
    </div>

    <!-- BOTTOM CENTER -->
    <div class="row justify-content-center mt-5">
        <div class="col-md-6">
            <div class="card p-3 shadow-sm text-center">
                <h5>Monthly Complaint Trends</h5>
                <canvas id="lineChart"></canvas>
            </div>
        </div>
    </div>

</div>

<script>

    let statusData = JSON.parse('${statusStatsJson}'.replace(/&quot;/g,'"'));
    let categoryData = JSON.parse('${categoryStatsJson}'.replace(/&quot;/g,'"'));
    let monthlyData = JSON.parse('${monthlyStatsJson}'.replace(/&quot;/g,'"'));
    let trendData = JSON.parse('${trendStatsJson}'.replace(/&quot;/g,'"'));

    // ================= PIE CHART =================
    new Chart(document.getElementById("pieChart"), {
        type: 'pie',
        data: {
            labels: Object.keys(statusData),
            datasets: [{
                data: Object.values(statusData)
            }]
        }
    });

    // ================= BAR CHART =================
    new Chart(document.getElementById("barChart"), {
        type: 'bar',
        data: {
            labels: Object.keys(categoryData),
            datasets: [{
                label: "Complaints by Category",
                data: Object.values(categoryData)
            }]
        }
    });

    // ================= LINE CHART (MONTHLY) =================
    let lineChart = new Chart(document.getElementById("lineChart"), {
        type: 'line',
        data: {
            labels: Object.keys(monthlyData),
            datasets: [{
                label: "Monthly Complaints",
                data: Object.values(monthlyData)
            }]
        }
    });

    // ================= FILTER UI =================
    function openFilter() {
        document.getElementById("filterBox").style.display = "block";
    }

    // ================= FILTER LOGIC =================
    function fetchReport() {
        let from = document.getElementById("fromDate").value;
        let to = document.getElementById("toDate").value;

        if (!from || !to) {
            alert("Please select both dates");
            return;
        }

        // Only enable download button
        document.getElementById("downloadBtn").disabled = false;
    }

    function checkDates() {
        let from = document.getElementById("fromDate").value;
        let to = document.getElementById("toDate").value;

        let btn = document.getElementById("downloadBtn");

        if (from && to) {
            btn.disabled = false;
        } else {
            btn.disabled = true;
        }
    }
    function downloadReport() {

        let from = document.getElementById("fromDate").value;
        let to = document.getElementById("toDate").value;

        if (!from || !to) {
            alert("Please select both dates");
            return;
        }

        if (from > to) {
            alert("From date cannot be greater than To date");
            return;
        }

        window.location.href = "/admin/reports/download?from=" + from + "&to=" + to;
    }
</script>

</body>
</html>