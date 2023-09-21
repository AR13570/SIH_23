import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/view/screen/verify.dart'; // Import GetX

class MyPhone extends StatefulWidget {
  static String verify = '';

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  final TextEditingController countryController =
      TextEditingController(text: "+91");

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

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
  bool isExpert = false;

  @override
  Widget build(BuildContext context) {
    if (stateList.isEmpty) {
      locationData.forEach((key, value) {
        stateList.add(key);
      });
    }
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please register before getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller:
                            nameController, // Controller for phone number input
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Are you an expert?"),
                  SizedBox(
                    width: 10,
                  ),
                  Switch(
                      value: isExpert,
                      onChanged: (changed) {
                        isExpert = changed;
                        setState(() {});
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton(
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
              if (state != null)
                Column(
                  children: [
                    DropdownButton(
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
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller:
                            phoneNumberController, // Controller for phone number input
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    // Concatenate the country code with the user's input
                    String fullPhoneNumber =
                        countryController.text + phoneNumberController.text;

                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber:
                          fullPhoneNumber, // Use the concatenated phone number
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        MyPhone.verify = verificationId;
                        Get.to(() => MyVerify(
                              district: district!,
                              phone: phoneNumberController.text,
                              state: state!,
                              isExpert: isExpert,
                              name: nameController.text,
                            ));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: const Text("Send the code"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
