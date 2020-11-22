//Model for JSON Provinces SouthAfrica
import 'package:forteapp/province_model.dart';

class Repository {
  List<Map> getAll() => _southafrica;

  getLocalByProvince(String province) => _southafrica
      .map((map) => ProvinceModel.fromJson(map))
      .where((item) => item.province == province)
      .map((item) => item.city)
      .expand((i) => i)
      .toList();

  List<String> getProvinces() => _southafrica
      .map((map) => ProvinceModel.fromJson(map))
      .map((item) => item.province)
      .toList();

  List _southafrica = [
    {
      "province": "Eastern Cape",
      "city": [
        "Alfred Nzo",
        "Amathole",
        "Buffalo City",
        "Cacadu",
        "Chris Hani",
        "Joe Gqabi",
        "Nelson Mandela Bay",
        "OR Tambo"
      ]
    },
    {
      "province": "Free State",
      "city": [
        "Fezile Dabi",
        "Lejweleputswa",
        "Mangaung",
        "Thabo Mofutsanyana",
        "Xhariep"
      ]
    },
    {
      "province": "Gauteng",
      "city": [
        "City of Johannesburg",
        "City of Tshwane",
        "Ekurhuleni",
        "Sedibeng",
        "West Rand"
      ]
    },
    {
      "province": "Limpopo",
      "city": ["Capricorn", "Mopani", "Sekhukhune", "Vhembe", "Waterberg"]
    },
    {
      "province": "Mpumalanga",
      "city": ["Ehlanzeni District", "Gert Sibande", "Nkangala", "Ugu"]
    },
    {
      "province": "KwaZulu-Natal",
      "city": [
        "Amajuba",
        "eThekwini",
        "iLembe",
        "Sisonke",
        "Ugu",
        "uMgungundlovu",
        "uMkhanyakude",
        "uMzinyathi",
        "uThukela",
        "uThungulu",
        "Zululand"
      ]
    },
    {
      "province": "North West",
      "city": [
        "Bojanala Platinum",
        "Dr Kenneth Kaunda",
        "Dr Ruth Segomotsi Mompati",
        "Ngaka Modiri Molema"
      ]
    },
    {
      "province": "Northern Cape",
      "city": [
        "Frances Baard",
        "John Taolo Gaetsewe",
        "Namakwa",
        "Pixley ka Seme",
        "Siyanda"
      ]
    },
    {
      "province": "Western Cape",
      "city": [
        "Cape Winelands",
        "Central Karoo",
        "City of Cape Town",
        "Eden",
        "Overberg",
        "West Coast"
      ]
    }
  ];
}
