abstract class CompanyEntity {
  final String name;
  final String logoPath;
  final String linkedInUrl;

  CompanyEntity({
    required this.name,
    required this.logoPath,
    required this.linkedInUrl,
  });

  String getCategory();
}

class FinanceCompany extends CompanyEntity {
  FinanceCompany({
    required super.name,
    required super.logoPath,
    required super.linkedInUrl,
  });

  @override
  String getCategory() => "Finance & Investment";
}

class ConsultingCompany extends CompanyEntity {
  ConsultingCompany({
    required super.name,
    required super.logoPath,
    required super.linkedInUrl,
  });

  @override
  String getCategory() => "Strategy Consulting";
}
