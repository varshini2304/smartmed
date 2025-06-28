import 'package:flutter/material.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen>
    with SingleTickerProviderStateMixin {
  // Primary color scheme
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFFE3F2FD);
  static const Color accentColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color errorColor = Color(0xFFF44336);

  late TabController _tabController;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Sample medical records data
  final List<Map<String, dynamic>> _allRecords = [
    {
      'title': 'Blood Test Report',
      'date': 'June 10, 2025',
      'doctor': 'Dr. Sharma',
      'type': 'Lab Report',
      'category': 'lab',
      'status': 'Normal',
      'fileSize': '2.1 MB',
      'description': 'Complete Blood Count (CBC) and Lipid Profile',
      'icon': Icons.bloodtype,
      'color': Colors.red,
    },
    {
      'title': 'X-Ray Chest',
      'date': 'May 22, 2025',
      'doctor': 'Dr. Patel',
      'type': 'Imaging',
      'category': 'imaging',
      'status': 'Clear',
      'fileSize': '5.3 MB',
      'description': 'Chest X-Ray - Routine checkup',
      'icon': Icons.local_hospital,
      'color': Colors.blue,
    },
    {
      'title': 'Prescription - Antibiotics',
      'date': 'June 15, 2025',
      'doctor': 'Dr. Meena',
      'type': 'Prescription',
      'category': 'prescription',
      'status': 'Active',
      'fileSize': '0.8 MB',
      'description': 'Amoxicillin 500mg - 7 days course',
      'icon': Icons.medication,
      'color': Colors.green,
    },
    {
      'title': 'Vaccination Certificate',
      'date': 'March 12, 2025',
      'doctor': 'Dr. Kumar',
      'type': 'Certificate',
      'category': 'certificate',
      'status': 'Valid',
      'fileSize': '1.2 MB',
      'description': 'COVID-19 Booster Shot Certificate',
      'icon': Icons.vaccines,
      'color': Colors.purple,
    },
    {
      'title': 'MRI Brain Scan',
      'date': 'April 8, 2025',
      'doctor': 'Dr. Singh',
      'type': 'Imaging',
      'category': 'imaging',
      'status': 'Normal',
      'fileSize': '15.7 MB',
      'description': 'Brain MRI with contrast - Headache investigation',
      'icon': Icons.psychology,
      'color': Colors.orange,
    },
    {
      'title': 'Discharge Summary',
      'date': 'February 20, 2025',
      'doctor': 'Dr. Gupta',
      'type': 'Hospital Record',
      'category': 'hospital',
      'status': 'Completed',
      'fileSize': '3.4 MB',
      'description': 'Post-surgery discharge summary and care instructions',
      'icon': Icons.assignment,
      'color': Colors.teal,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredRecords {
    var records = _allRecords.where((record) {
      final matchesSearch = _searchQuery.isEmpty ||
          record['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record['doctor'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record['type'].toString().toLowerCase().contains(_searchQuery.toLowerCase());

      final currentTab = _tabController.index;
      if (currentTab == 0) return matchesSearch; // All

      final categories = ['lab', 'imaging', 'prescription', 'certificate'];
      if (currentTab <= categories.length) {
        return matchesSearch && record['category'] == categories[currentTab - 1];
      }

      return matchesSearch;
    }).toList();

    // Sort by date (newest first)
    records.sort((a, b) => DateTime.parse('2025-${_parseDate(b['date'])}')
        .compareTo(DateTime.parse('2025-${_parseDate(a['date'])}')));

    return records;
  }

  String _parseDate(String dateStr) {
    final months = {
      'January': '01', 'February': '02', 'March': '03', 'April': '04',
      'May': '05', 'June': '06', 'July': '07', 'August': '08',
      'September': '09', 'October': '10', 'November': '11', 'December': '12'
    };

    final parts = dateStr.split(' ');
    final month = months[parts[0]] ?? '01';
    final day = parts[1].replaceAll(',', '').padLeft(2, '0');
    return '$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        title: const Text(
          'Medical Records',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareRecords,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search bar
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search records, doctors, or types...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey[400]),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              // Tab bar
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                onTap: (index) {
                  setState(() {});
                },
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Lab Reports'),
                  Tab(text: 'Imaging'),
                  Tab(text: 'Prescriptions'),
                  Tab(text: 'Certificates'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Statistics bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Records',
                    _allRecords.length.toString(),
                    Icons.folder,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'This Month',
                    _allRecords.where((r) => r['date'].contains('June')).length.toString(),
                    Icons.calendar_today,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Filtered',
                    _filteredRecords.length.toString(),
                    Icons.filter_alt,
                  ),
                ),
              ],
            ),
          ),
          // Records list
          Expanded(
            child: _filteredRecords.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredRecords.length,
                    itemBuilder: (context, index) {
                      final record = _filteredRecords[index];
                      return _buildRecordCard(record, index);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        onPressed: _uploadNewRecord,
        icon: const Icon(Icons.add),
        label: const Text('Upload Record'),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryBlue, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _buildRecordCard(record, index),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Record type icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: record['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    record['icon'],
                    color: record['color'],
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                // Record details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        record['description'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.person, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            record['doctor'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            record['date'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status and actions
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(record['status']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        record['status'],
                        style: TextStyle(
                          color: _getStatusColor(record['status']),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      record['fileSize'],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 8),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: Colors.grey[400], size: 20),
                      onSelected: (value) => _handleRecordAction(value, record),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'view',
                          child: Row(
                            children: [
                              Icon(Icons.visibility, size: 16),
                              SizedBox(width: 8),
                              Text('View'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'download',
                          child: Row(
                            children: [
                              Icon(Icons.download, size: 16),
                              SizedBox(width: 8),
                              Text('Download'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'share',
                          child: Row(
                            children: [
                              Icon(Icons.share, size: 16),
                              SizedBox(width: 8),
                              Text('Share'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 16, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No Records Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try adjusting your search criteria'
                : 'Upload your first medical record to get started',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: _uploadNewRecord,
            icon: const Icon(Icons.add),
            label: const Text('Upload Record'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
      case 'clear':
      case 'valid':
      case 'completed':
        return accentColor;
      case 'active':
        return primaryBlue;
      default:
        return warningColor;
    }
  }

  void _viewRecord(Map<String, dynamic> record) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: record['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      record['icon'],
                      color: record['color'],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          record['type'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDetailRow('Doctor', record['doctor']),
              _buildDetailRow('Date', record['date']),
              _buildDetailRow('Status', record['status']),
              _buildDetailRow('File Size', record['fileSize']),
              _buildDetailRow('Description', record['description']),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // Open record
                      },
                      icon: const Icon(Icons.visibility),
                      label: const Text('View'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryBlue,
                        side: BorderSide(color: primaryBlue),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // Download record
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Download'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleRecordAction(String action, Map<String, dynamic> record) {
    switch (action) {
      case 'view':
        _viewRecord(record);
        break;
      case 'download':
      // Download functionality
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Downloading ${record['title']}...')),
        );
        break;
      case 'share':
      // Share functionality
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sharing ${record['title']}...')),
        );
        break;
      case 'delete':
        _deleteRecord(record);
        break;
    }
  }

  void _deleteRecord(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Record'),
        content: Text('Are you sure you want to delete "${record['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: errorColor),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _allRecords.remove(record);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Record deleted successfully')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    // Filter options implementation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filter options coming soon...')),
    );
  }

  void _shareRecords() {
    // Share records implementation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing records...')),
    );
  }

  void _uploadNewRecord() {
    // Upload new record implementation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Upload functionality coming soon...')),
    );
  }
}
