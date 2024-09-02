import 'package:flutter/material.dart';

class CropDetail extends StatelessWidget {
  final String cropName;
  final String cropImage;
  final String description;
  final String nutritionalValue;
  final List<Map<String, String>> diseases;

  const CropDetail({
    super.key,
    required this.cropName,
    required this.cropImage,
    required this.description,
    required this.nutritionalValue,
    required this.diseases,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cropName),
        backgroundColor: const Color(0xFF004d40), // Brand color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Image.asset(
                  cropImage,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            // Description Card
            _buildInfoCard('Description', description),
            // Nutritional Value Card
            _buildInfoCard('Nutritional Value', nutritionalValue),
            // Diseases Card
            ...diseases.map((disease) => _buildDiseaseCard(disease)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiseaseCard(Map<String, String> disease) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                disease['name']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildDiseaseDetail('Cause', disease['cause']!),
              _buildDiseaseDetail('Effect', disease['effect']!),
              _buildDiseaseDetail('Solution', disease['solution']!),
              _buildDiseaseDetail('Best Practice', disease['bestPractice']!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiseaseDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              detail,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
