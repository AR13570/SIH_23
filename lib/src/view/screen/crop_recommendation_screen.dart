import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:office_app_store/core/app_style.dart';

class CropRecommendationScreen extends StatefulWidget {
  @override
  State<CropRecommendationScreen> createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  final CropRecommendationController controller =
      Get.put(CropRecommendationController());

  String? state;

  String? district;

  Map locationData = {
    'Andaman and Nicobar Islands': [
      'NICOBARS',
      'NORTH AND MIDDLE ANDAMAN',
      'SOUTH ANDAMANS'
    ],
    'Andhra Pradesh': [
      'ANANTAPUR',
      'CHITTOOR',
      'EAST GODAVARI',
      'GUNTUR',
      'KADAPA',
      'KRISHNA',
      'KURNOOL',
      'PRAKASAM',
      'SPSR NELLORE',
      'SRIKAKULAM',
      'VISAKHAPATANAM',
      'VIZIANAGARAM',
      'WEST GODAVARI'
    ],
    'Arunachal Pradesh': [
      'ANJAW',
      'CHANGLANG',
      'DIBANG VALLEY',
      'EAST KAMENG',
      'EAST SIANG',
      'KURUNG KUMEY',
      'LOHIT',
      'LONGDING',
      'LOWER DIBANG VALLEY',
      'LOWER SUBANSIRI',
      'NAMSAI',
      'PAPUM PARE',
      'TAWANG',
      'TIRAP',
      'UPPER SIANG',
      'UPPER SUBANSIRI',
      'WEST KAMENG',
      'WEST SIANG'
    ],
    'Assam': [
      'BAKSA',
      'BARPETA',
      'BONGAIGAON',
      'CACHAR',
      'CHIRANG',
      'DARRANG',
      'DHEMAJI',
      'DHUBRI',
      'DIBRUGARH',
      'DIMA HASAO',
      'GOALPARA',
      'GOLAGHAT',
      'HAILAKANDI',
      'JORHAT',
      'KAMRUP',
      'KAMRUP METRO',
      'KARBI ANGLONG',
      'KARIMGANJ',
      'KOKRAJHAR',
      'LAKHIMPUR',
      'MARIGAON',
      'NAGAON',
      'NALBARI',
      'SIVASAGAR',
      'SONITPUR',
      'TINSUKIA',
      'UDALGURI'
    ],
    'Bihar': [
      'ARARIA',
      'ARWAL',
      'AURANGABAD',
      'BANKA',
      'BEGUSARAI',
      'BHAGALPUR',
      'BHOJPUR',
      'BUXAR',
      'DARBHANGA',
      'GAYA',
      'GOPALGANJ',
      'JAMUI',
      'JEHANABAD',
      'KAIMUR (BHABUA)',
      'KATIHAR',
      'KHAGARIA',
      'KISHANGANJ',
      'LAKHISARAI',
      'MADHEPURA',
      'MADHUBANI',
      'MUNGER',
      'MUZAFFARPUR',
      'NALANDA',
      'NAWADA',
      'PASHCHIM CHAMPARAN',
      'PATNA',
      'PURBI CHAMPARAN',
      'PURNIA',
      'ROHTAS',
      'SAHARSA',
      'SAMASTIPUR',
      'SARAN',
      'SHEIKHPURA',
      'SHEOHAR',
      'SITAMARHI',
      'SIWAN',
      'SUPAUL',
      'VAISHALI'
    ],
    'Chandigarh': ['CHANDIGARH'],
    'Chhattisgarh': [
      'BALOD',
      'BALODA BAZAR',
      'BALRAMPUR',
      'BASTAR',
      'BEMETARA',
      'BIJAPUR',
      'BILASPUR',
      'DANTEWADA',
      'DHAMTARI',
      'DURG',
      'GARIYABAND',
      'JANJGIR-CHAMPA',
      'JASHPUR',
      'KABIRDHAM',
      'KANKER',
      'KONDAGAON',
      'KORBA',
      'KOREA',
      'MAHASAMUND',
      'MUNGELI',
      'NARAYANPUR',
      'RAIGARH',
      'RAIPUR',
      'RAJNANDGAON',
      'SUKMA',
      'SURAJPUR',
      'SURGUJA'
    ],
    'Dadra and Nagar Haveli': ['DADRA AND NAGAR HAVELI'],
    'Goa': ['NORTH GOA', 'SOUTH GOA'],
    'Gujarat': [
      'AHMADABAD',
      'AMRELI',
      'ANAND',
      'BANAS KANTHA',
      'BHARUCH',
      'BHAVNAGAR',
      'DANG',
      'DOHAD',
      'GANDHINAGAR',
      'JAMNAGAR',
      'JUNAGADH',
      'KACHCHH',
      'KHEDA',
      'MAHESANA',
      'NARMADA',
      'NAVSARI',
      'PANCH MAHALS',
      'PATAN',
      'PORBANDAR',
      'RAJKOT',
      'SABAR KANTHA',
      'SURAT',
      'SURENDRANAGAR',
      'TAPI',
      'VADODARA',
      'VALSAD'
    ],
    'Haryana': [
      'AMBALA',
      'BHIWANI',
      'FARIDABAD',
      'FATEHABAD',
      'GURGAON',
      'HISAR',
      'JHAJJAR',
      'JIND',
      'KAITHAL',
      'KARNAL',
      'KURUKSHETRA',
      'MAHENDRAGARH',
      'MEWAT',
      'PALWAL',
      'PANCHKULA',
      'PANIPAT',
      'REWARI',
      'ROHTAK',
      'SIRSA',
      'SONIPAT',
      'YAMUNANAGAR'
    ],
    'Himachal Pradesh': [
      'BILASPUR',
      'CHAMBA',
      'HAMIRPUR',
      'KANGRA',
      'KINNAUR',
      'KULLU',
      'LAHUL AND SPITI',
      'MANDI',
      'SHIMLA',
      'SIRMAUR',
      'SOLAN',
      'UNA'
    ],
    'Jammu and Kashmir ': [
      'ANANTNAG',
      'BADGAM',
      'BANDIPORA',
      'BARAMULLA',
      'DODA',
      'GANDERBAL',
      'JAMMU',
      'KARGIL',
      'KATHUA',
      'KISHTWAR',
      'KULGAM',
      'KUPWARA',
      'LEH LADAKH',
      'POONCH',
      'PULWAMA',
      'RAJAURI',
      'RAMBAN',
      'REASI',
      'SAMBA',
      'SHOPIAN',
      'SRINAGAR',
      'UDHAMPUR'
    ],
    'Jharkhand': [
      'BOKARO',
      'CHATRA',
      'DEOGHAR',
      'DHANBAD',
      'DUMKA',
      'EAST SINGHBUM',
      'GARHWA',
      'GIRIDIH',
      'GODDA',
      'GUMLA',
      'HAZARIBAGH',
      'JAMTARA',
      'KHUNTI',
      'KODERMA',
      'LATEHAR',
      'LOHARDAGA',
      'PAKUR',
      'PALAMU',
      'RAMGARH',
      'RANCHI',
      'SAHEBGANJ',
      'SARAIKELA KHARSAWAN',
      'SIMDEGA',
      'WEST SINGHBHUM'
    ],
    'Karnataka': [
      'BAGALKOT',
      'BANGALORE RURAL',
      'BELGAUM',
      'BELLARY',
      'BENGALURU URBAN',
      'BIDAR',
      'BIJAPUR',
      'CHAMARAJANAGAR',
      'CHIKBALLAPUR',
      'CHIKMAGALUR',
      'CHITRADURGA',
      'DAKSHIN KANNAD',
      'DAVANGERE',
      'DHARWAD',
      'GADAG',
      'GULBARGA',
      'HASSAN',
      'HAVERI',
      'KODAGU',
      'KOLAR',
      'KOPPAL',
      'MANDYA',
      'MYSORE',
      'RAICHUR',
      'RAMANAGARA',
      'SHIMOGA',
      'TUMKUR',
      'UDUPI',
      'UTTAR KANNAD',
      'YADGIR'
    ],
    'Kerala': [
      'ALAPPUZHA',
      'ERNAKULAM',
      'IDUKKI',
      'KANNUR',
      'KASARAGOD',
      'KOLLAM',
      'KOTTAYAM',
      'KOZHIKODE',
      'MALAPPURAM',
      'PALAKKAD',
      'PATHANAMTHITTA',
      'THIRUVANANTHAPURAM',
      'THRISSUR',
      'WAYANAD'
    ],
    'Madhya Pradesh': [
      'AGAR MALWA',
      'ALIRAJPUR',
      'ANUPPUR',
      'ASHOKNAGAR',
      'BALAGHAT',
      'BARWANI',
      'BETUL',
      'BHIND',
      'BHOPAL',
      'BURHANPUR',
      'CHHATARPUR',
      'CHHINDWARA',
      'DAMOH',
      'DATIA',
      'DEWAS',
      'DHAR',
      'DINDORI',
      'GUNA',
      'GWALIOR',
      'HARDA',
      'HOSHANGABAD',
      'INDORE',
      'JABALPUR',
      'JHABUA',
      'KATNI',
      'KHANDWA',
      'KHARGONE',
      'MANDLA',
      'MANDSAUR',
      'MORENA',
      'NARSINGHPUR',
      'NEEMUCH',
      'PANNA',
      'RAISEN',
      'RAJGARH',
      'RATLAM',
      'REWA',
      'SAGAR',
      'SATNA',
      'SEHORE',
      'SEONI',
      'SHAHDOL',
      'SHAJAPUR',
      'SHEOPUR',
      'SHIVPURI',
      'SIDHI',
      'SINGRAULI',
      'TIKAMGARH',
      'UJJAIN',
      'UMARIA',
      'VIDISHA'
    ],
    'Maharashtra': [
      'AHMEDNAGAR',
      'AKOLA',
      'AMRAVATI',
      'AURANGABAD',
      'BEED',
      'BHANDARA',
      'BULDHANA',
      'CHANDRAPUR',
      'DHULE',
      'GADCHIROLI',
      'GONDIA',
      'HINGOLI',
      'JALGAON',
      'JALNA',
      'KOLHAPUR',
      'LATUR',
      'MUMBAI',
      'NAGPUR',
      'NANDED',
      'NANDURBAR',
      'NASHIK',
      'OSMANABAD',
      'PALGHAR',
      'PARBHANI',
      'PUNE',
      'RAIGAD',
      'RATNAGIRI',
      'SANGLI',
      'SATARA',
      'SINDHUDURG',
      'SOLAPUR',
      'THANE',
      'WARDHA',
      'WASHIM',
      'YAVATMAL'
    ],
    'Manipur': [
      'BISHNUPUR',
      'CHANDEL',
      'CHURACHANDPUR',
      'IMPHAL EAST',
      'IMPHAL WEST',
      'SENAPATI',
      'TAMENGLONG',
      'THOUBAL',
      'UKHRUL'
    ],
    'Meghalaya': [
      'EAST GARO HILLS',
      'EAST JAINTIA HILLS',
      'EAST KHASI HILLS',
      'NORTH GARO HILLS',
      'RI BHOI',
      'SOUTH GARO HILLS',
      'SOUTH WEST GARO HILLS',
      'SOUTH WEST KHASI HILLS',
      'WEST GARO HILLS',
      'WEST JAINTIA HILLS',
      'WEST KHASI HILLS'
    ],
    'Mizoram': [
      'AIZAWL',
      'CHAMPHAI',
      'KOLASIB',
      'LAWNGTLAI',
      'LUNGLEI',
      'MAMIT',
      'SAIHA',
      'SERCHHIP'
    ],
    'Nagaland': [
      'DIMAPUR',
      'KIPHIRE',
      'KOHIMA',
      'LONGLENG',
      'MOKOKCHUNG',
      'MON',
      'PEREN',
      'PHEK',
      'TUENSANG',
      'WOKHA',
      'ZUNHEBOTO'
    ],
    'Odisha': [
      'ANUGUL',
      'BALANGIR',
      'BALESHWAR',
      'BARGARH',
      'BHADRAK',
      'BOUDH',
      'CUTTACK',
      'DEOGARH',
      'DHENKANAL',
      'GAJAPATI',
      'GANJAM',
      'JAGATSINGHAPUR',
      'JAJAPUR',
      'JHARSUGUDA',
      'KALAHANDI',
      'KANDHAMAL',
      'KENDRAPARA',
      'KENDUJHAR',
      'KHORDHA',
      'KORAPUT',
      'MALKANGIRI',
      'MAYURBHANJ',
      'NABARANGPUR',
      'NAYAGARH',
      'NUAPADA',
      'PURI',
      'RAYAGADA',
      'SAMBALPUR',
      'SONEPUR',
      'SUNDARGARH'
    ],
    'Puducherry': ['KARAIKAL', 'MAHE', 'PONDICHERRY', 'YANAM'],
    'Punjab': [
      'AMRITSAR',
      'BARNALA',
      'BATHINDA',
      'FARIDKOT',
      'FATEHGARH SAHIB',
      'FAZILKA',
      'FIROZEPUR',
      'GURDASPUR',
      'HOSHIARPUR',
      'JALANDHAR',
      'KAPURTHALA',
      'LUDHIANA',
      'MANSA',
      'MOGA',
      'MUKTSAR',
      'NAWANSHAHR',
      'PATHANKOT',
      'PATIALA',
      'RUPNAGAR',
      'S.A.S NAGAR',
      'SANGRUR',
      'TARN TARAN'
    ],
    'Rajasthan': [
      'AJMER',
      'ALWAR',
      'BANSWARA',
      'BARAN',
      'BARMER',
      'BHARATPUR',
      'BHILWARA',
      'BIKANER',
      'BUNDI',
      'CHITTORGARH',
      'CHURU',
      'DAUSA',
      'DHOLPUR',
      'DUNGARPUR',
      'GANGANAGAR',
      'HANUMANGARH',
      'JAIPUR',
      'JAISALMER',
      'JALORE',
      'JHALAWAR',
      'JHUNJHUNU',
      'JODHPUR',
      'KARAULI',
      'KOTA',
      'NAGAUR',
      'PALI',
      'PRATAPGARH',
      'RAJSAMAND',
      'SAWAI MADHOPUR',
      'SIKAR',
      'SIROHI',
      'TONK',
      'UDAIPUR'
    ],
    'Sikkim': [
      'EAST DISTRICT',
      'NORTH DISTRICT',
      'SOUTH DISTRICT',
      'WEST DISTRICT'
    ],
    'Tamil Nadu': [
      'ARIYALUR',
      'COIMBATORE',
      'CUDDALORE',
      'DHARMAPURI',
      'DINDIGUL',
      'ERODE',
      'KANCHIPURAM',
      'KANNIYAKUMARI',
      'KARUR',
      'KRISHNAGIRI',
      'MADURAI',
      'NAGAPATTINAM',
      'NAMAKKAL',
      'PERAMBALUR',
      'PUDUKKOTTAI',
      'RAMANATHAPURAM',
      'SALEM',
      'SIVAGANGA',
      'THANJAVUR',
      'THE NILGIRIS',
      'THENI',
      'THIRUVALLUR',
      'THIRUVARUR',
      'TIRUCHIRAPPALLI',
      'TIRUNELVELI',
      'TIRUPPUR',
      'TIRUVANNAMALAI',
      'TUTICORIN',
      'VELLORE',
      'VILLUPURAM',
      'VIRUDHUNAGAR'
    ],
    'Telangana ': [
      'ADILABAD',
      'HYDERABAD',
      'KARIMNAGAR',
      'KHAMMAM',
      'MAHBUBNAGAR',
      'MEDAK',
      'NALGONDA',
      'NIZAMABAD',
      'RANGAREDDI',
      'WARANGAL'
    ],
    'Tripura': [
      'DHALAI',
      'GOMATI',
      'KHOWAI',
      'NORTH TRIPURA',
      'SEPAHIJALA',
      'SOUTH TRIPURA',
      'UNAKOTI',
      'WEST TRIPURA'
    ],
    'Uttar Pradesh': [
      'AGRA',
      'ALIGARH',
      'ALLAHABAD',
      'AMBEDKAR NAGAR',
      'AMETHI',
      'AMROHA',
      'AURAIYA',
      'AZAMGARH',
      'BAGHPAT',
      'BAHRAICH',
      'BALLIA',
      'BALRAMPUR',
      'BANDA',
      'BARABANKI',
      'BAREILLY',
      'BASTI',
      'BIJNOR',
      'BUDAUN',
      'BULANDSHAHR',
      'CHANDAULI',
      'CHITRAKOOT',
      'DEORIA',
      'ETAH',
      'ETAWAH',
      'FAIZABAD',
      'FARRUKHABAD',
      'FATEHPUR',
      'FIROZABAD',
      'GAUTAM BUDDHA NAGAR',
      'GHAZIABAD',
      'GHAZIPUR',
      'GONDA',
      'GORAKHPUR',
      'HAMIRPUR',
      'HAPUR',
      'HARDOI',
      'HATHRAS',
      'JALAUN',
      'JAUNPUR',
      'JHANSI',
      'KANNAUJ',
      'KANPUR DEHAT',
      'KANPUR NAGAR',
      'KASGANJ',
      'KAUSHAMBI',
      'KHERI',
      'KUSHI NAGAR',
      'LALITPUR',
      'LUCKNOW',
      'MAHARAJGANJ',
      'MAHOBA',
      'MAINPURI',
      'MATHURA',
      'MAU',
      'MEERUT',
      'MIRZAPUR',
      'MORADABAD',
      'MUZAFFARNAGAR',
      'PILIBHIT',
      'PRATAPGARH',
      'RAE BARELI',
      'RAMPUR',
      'SAHARANPUR',
      'SAMBHAL',
      'SANT KABEER NAGAR',
      'SANT RAVIDAS NAGAR',
      'SHAHJAHANPUR',
      'SHAMLI',
      'SHRAVASTI',
      'SIDDHARTH NAGAR',
      'SITAPUR',
      'SONBHADRA',
      'SULTANPUR',
      'UNNAO',
      'VARANASI'
    ],
    'Uttarakhand': [
      'ALMORA',
      'BAGESHWAR',
      'CHAMOLI',
      'CHAMPAWAT',
      'DEHRADUN',
      'HARIDWAR',
      'NAINITAL',
      'PAURI GARHWAL',
      'PITHORAGARH',
      'RUDRA PRAYAG',
      'TEHRI GARHWAL',
      'UDAM SINGH NAGAR',
      'UTTAR KASHI'
    ],
    'West Bengal': [
      '24 PARAGANAS NORTH',
      '24 PARAGANAS SOUTH',
      'BANKURA',
      'BARDHAMAN',
      'BIRBHUM',
      'COOCHBEHAR',
      'DARJEELING',
      'DINAJPUR DAKSHIN',
      'DINAJPUR UTTAR',
      'HOOGHLY',
      'HOWRAH',
      'JALPAIGURI',
      'MALDAH',
      'MEDINIPUR EAST',
      'MEDINIPUR WEST',
      'MURSHIDABAD',
      'NADIA',
      'PURULIA'
    ]
  };

  List stateList = [];

  List districtList = [];

  @override
  void initState() {
    locationData.forEach((key, value) {
      stateList.add(key);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crop Recommendation',
          style: h2Style,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Image.asset(
                    "assets/images/crop.png",
                    width: 90,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Expanded(
                    child: Text(
                      "Identify best crops to grow based on your location",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DropdownButton(
                      hint: const Text("Pick a state"),
                      value: state,
                      items: stateList
                          .map((e) => DropdownMenuItem(
                                value: e.toString(),
                                child: Text(e.toString().capitalize ?? ""),
                              ))
                          .toList(),
                      onChanged: (String? selected) {
                        if (selected != null) {
                          state = selected;
                          district = null;
                          districtList = locationData[state];
                          setState(() {});
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButton(
                      hint: const Text("Pick a district"),
                      value: district,
                      items: districtList
                          .map((e) => DropdownMenuItem(
                                value: e.toString(),
                                child: Text(e.toString().capitalize ?? ""),
                              ))
                          .toList(),
                      onChanged: (String? selected) {
                        if (selected != null) {
                          district = selected;
                          setState(() {});
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (district != null) {
                    controller.districtController.text = district!;
                    controller.monthController.text =
                        DateFormat('MMMM').format(DateTime.now());
                    controller.fetchRecommendation();
                  } else {
                    controller.result.value = "Please select a district";
                  }
                },
                child: const Text('Get Crop Recommendation'),
              ),
              const SizedBox(height: 16),
              Obx(() {
                String? recommendation = controller.result.value;
                if (recommendation == "") {
                  return Container();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Recommendation:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      // Text(
                      //   'Whole Year Crops :',
                      //   style:
                      //       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // ),
                      // Text(
                      //   controller.wholeYearList.toString(),
                      //   style: TextStyle(fontSize: 18),
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // Text(
                      //   'Top Crops :',
                      //   style:
                      //       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // ),
                      // Text(
                      //   controller.topCrops.toString(),
                      //   style: TextStyle(fontSize: 18),
                      //   textAlign: TextAlign.center,
                      // )

                      controller.wholeYearList.value.isNotEmpty?
                        Padding(
                          padding: const EdgeInsets.all( 10.0),
                          child: Text(
                            'Whole Year Crops:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ):CircularProgressIndicator(color: Colors.lightGreen,),

                      controller.wholeYearList.value.isNotEmpty?
                        ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: controller.wholeYearList.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Container(

                                padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                            color: Colors.lightGreen,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                            ),
                                child: Text(
                                  controller.wholeYearList.value[index],
                                  style: TextStyle(fontSize: 18,color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ):CircularProgressIndicator(color: Colors.lightGreen,),

                      // Top Crops ListView.builder
                      if (controller.topCrops.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            'Top Crops:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      if (controller.topCrops.value.isNotEmpty)
                        ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: controller.topCrops.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var entry = controller.topCrops.value.entries.elementAt(index);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${entry.key}',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListView.builder(
                                  physics: ClampingScrollPhysics(),

                                  itemCount: entry.value.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    return ListTile(
                                      title: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                                        ),
                                        //color: Colors.green,
                                        child: Text(
                                          entry.value[i],
                                          style: TextStyle(fontSize: 18,
                                          color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 16),
                              ],
                            );
                          },
                        ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CropRecommendationController extends GetxController {
  TextEditingController districtController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  RxString result = RxString('');
  RxList<dynamic> wholeYearList = RxList();
  RxMap<dynamic, List<dynamic>> topCrops = RxMap();

  void fetchRecommendation() async {
    final district = districtController.text;
    final month = monthController.text;

    final apiUrl = 'http://192.168.89.132:5000/crop'; // Update with your API endpoint
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'district': district,
        'month': month,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Check if the data types are as expected
      if (data['whole_year_crop'] is List && data['top_crop'] is Map) {
        wholeYearList.value=(List<dynamic>.from(data['whole_year_crop']));
        topCrops.value
        =Map<dynamic, List<dynamic>>.from(data['top_crop']);

        result.value =
        'Whole Year Crop: ${wholeYearList.toString()}\nTop Crop: ${topCrops.toString()}';
      } else {
        result.value = 'Error: Invalid data format in response';
      }
    } else {
      result.value =
      'Error: Unable to fetch recommendation ${response.statusCode}';
    }
  }

}
