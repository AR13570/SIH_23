import 'package:flutter/material.dart';

class Cure extends StatelessWidget {
  String diseaseName;
  Cure(this.diseaseName);
  final disease = {
  "Apple_Scab": "Choose resistant varieties when possible. Rake under trees and destroy infected leaves to reduce the number of fungal spores available to start the disease cycle over again next spring. Water in the evening or early morning hours (avoid overhead irrigation) to give the leaves time to dry out before infection can occur. Spread a 3- to 6-inch layer of compost under trees, keeping it away from the trunk, to cover soil and prevent splash dispersal of the fungal spores. For best control, spray liquid copper soap early, two weeks before symptoms normally appear. Alternatively, begin applications when the disease first appears, and repeat at 7 to 10 day intervals up to blossom drop.",

  "Apple_Black_Rot": "Remove the cankers by pruning at least 15 inches below the end and burn or bury them. Also take preventative care with new season prunings and burn them, too. You are better off pruning during the dormant season. This will minimize the odds that fire blight will infect your tree and produce dead tissue that can easily be infected by Botryosphaeria. You should also take precautions if the bark is damaged by hail, or branches break during a windstorm. Using a copper-based fungicide will protect against both black rot and fire blight.",

  "Apple_Cedar_Rust": "Choose resistant cultivars when available. Rake up and dispose of fallen leaves and other debris from under trees. Remove galls from infected junipers. In some cases, juniper plants should be removed entirely. Apply preventative, disease-fighting fungicides labeled for use on apples weekly, starting with bud break, to protect trees from spores being released by the juniper host. This occurs only once per year, so additional applications after this springtime spread are not necessary. On juniper, rust can be controlled by spraying plants with a copper solution (0.5 to 2.0 oz/gallon of water) at least four times between late August and late October. Safely treat most fungal and bacterial diseases with SERENADE Garden. This broad spectrum bio-fungicide uses a patented strain of Bacillus subtilis that is registered for organic use. Best of all, SERENADE is completely non-toxic to honey bees and beneficial insects.",

  "Apple_Healthy": "Healthy Apple",

  "Blueberry_Healthy": "Healthy Blueberry",

  "Cherry_Powdery_Mildew": "Disinfect the cutting edges, then prune out and discard the diseased portions of the plant immediately. At the same time, apply fungicides to protect the remaining leaves on the fruit tree. You'll need to repeat the fungicide applications according to label instructions to protect the trees over the entire season.",

  "Cherry_Healthy": "healthy Cherry",

  "Corn_Cercospora_Leaf_Spot_Gray_Leaf_Spot": "Irrigate deeply, but infrequently. Avoid using post-emergent weed killers on the lawn while the disease is active. Avoid medium to high nitrogen fertilizer levels. Improve air circulation and light level on lawn. Mow at the proper height and only mow when the grass is dry.",

  "Corn_Common_Rust": "To reduce the incidence of corn rust, plant only corn that has resistance to the fungus. Resistance is either in the form of race-specific resistance or partial rust resistance. In either case, no sweet corn is completely resistant. If the corn begins to show symptoms of infection, immediately spray with a fungicide.",

  "Corn_Northern_Leaf_Blight": "Fungicide applications reduced Northern Corn Leaf Blight damage and protected yield. Fungicide value was higher in reducing yield in susceptible corn hybrids. Fungicide were most effective if they were applied at disease onset. Disease onset varied in growth stages, and so the best stage to apply fungicides.",

  "Corn_Healthy": "Healthy Corn",

  "Grape_Black_Rot": "Mancozeb is available as BONIDE MANCOZEB FLOWABLE fungicide. It contains 37% Mancozeb and should be very effective for controlling black rot. Nova (myclobutanil) is available in IMMUNOX FUNGICIDE. It is 1.55 % myclobutanil and should be effective for controlling black rot.",

  "Grape_Esca_Black_Measles": "Till date there is no effective method to control this disease. Remove the infected berries, leaves, and trunk and destroy them. Protect the prune wounds to minimize fungal infection using wound sealant (5% boric acid in acrylic paint) or essential oil or suitable fungicides.",

  "Grape_Leaf_Blight_Isariopsis_Leaf_Spot": "Apply dormant sprays to reduce inoculum levels. Cut it out. Open up that canopy. Don't let down your defenses. Scout early, scout often. Use protectant and systemic fungicides. Consider fungicide resistance. Watch the weather.",

  "Grape_Healthy": "Healthy Grape",

  "Orange_Haunglongbing_Citrus_Greening": "The only way to prevent the spread of Citrus Greening Disease is to control ACP (Asian Citrus Psyllid). Since citrus is such a popular and widely-planted garden tree, homeowners are on the front lines of this important battle. Spray the lemon tree with Neem oil insecticide, both the top and undersides of the foliage. You may need to repeat in 10-14 days, depending upon the extent of the infestation. Follow up by treating the mold growth with liquid copper fungicide.",

  "Peach_Bacterial_Spot": "Fruit symptoms of bacterial spot may be confused with peach scab, caused by the fungus Cladosporium carpophyllium, however scab spots are more circular, have a dark brown/greenish, fuzzy appearance, and do not pit the fruit surface, although skin cracking can occur. Scab does not cause leaf symptoms but can cause spots on twigs. Initial fruit spots of bacterial spot may be superficial but develop into craters.",

  "Peach_Healthy": "Healthy Peach",

  "Pepper_Bell_Bacterial_Spot": "Select resistant varieties. Purchase disease-free seed and transplants. Treat seeds by soaking them for 2 minutes in a 10% chlorine bleach solution (1 part bleach; 9 parts water). Thoroughly rinse seeds and dry them before planting. Mulch plants deeply with a thick organic material like newspaper covered with straw or grass clippings. Avoid overhead watering. Remove and discard badly infected plant parts and all debris at the end of the season. Spray every 10-14 days with fixed copper (organic fungicide) to slow down the spread of infection. Rotate peppers to a different location if infections are severe and cover the soil with black plastic mulch or black landscape fabric prior to planting.",

  "Pepper_Bell_Healthy": "Healthy Bell Pepper",

  "Potato_Early_Blight": "Treatment of early blight includes prevention by planting potato varieties that are resistant to the disease; late maturing are more resistant than early maturing varieties. Avoid overhead irrigation and allow for sufficient aeration between plants to allow the foliage to dry as quickly as possible.",

  "Potato_Late_Blight": "The severe late blight can be effectively managed with prophylactic spray of mancozeb at 0.25% followed by cymoxanil+mancozeb or dimethomorph+mancozeb at 0.3% at the onset of disease and one more spray of mancozeb at 0.25% seven days after application of systemic fungicides in West Bengal.",

  "Potato_Healthy": "Healthy Potato",

  "Raspberry_Healthy": "Healthy Raspberry",

  "Soybean_Healthy": "Healthy Soybean",

  "Squash_Powdery_Mildew": "Combine one tablespoon baking soda and one-half teaspoon of liquid, non-detergent soap with one gallon of water, and spray the mixture liberally on the plants. Mouthwash. The mouthwash you may use on a daily basis for killing the germs in your mouth can also be effective at killing powdery mildew spores.",

  "Strawberry_Leaf_Scorch": "While leaf scorch on strawberry plants can be frustrating, there are some strategies which home gardeners may employ to help prevent its spread in the garden. The primary means of strawberry leaf scorch control should always be prevention. Since this fungal pathogen overwinters on the fallen leaves of infected plants, proper garden sanitation is key. This includes the removal of infected garden debris from the strawberry patch, as well as the frequent establishment of new strawberry transplants. The creation of new plantings and strawberry patches is key to maintaining a consistent strawberry harvest, as older plants are more likely to show signs of severe infection.",

  "Strawberry_Healthy": "Healthy Strawberry",

  "Tomato_Bacterial_Spot": "Plant pathogen-free seed or transplants to prevent the introduction of bacterial spot pathogens on contaminated seed or seedlings. If a clean seed source is not available or you suspect that your seed is contaminated, soak seeds in water at 122°F for 25 min. to kill the pathogens. To keep leaves dry and to prevent the spread of the pathogens, avoid overhead watering (e.g., with a wand or sprinkler) of established plants and instead use a drip-tape or soaker-hose. Also, to prevent spread, DO NOT handle plants when they are wet (e.g., from dew) and routinely sterilize tools with either 10% bleach solution or (better) 70% alcohol (e.g., rubbing alcohol). Where bacterial spot has been a recurring problem, consider using preventative applications of copper-based products registered for use on tomato, especially during warm, wet periods. Keep in mind, however, that if used excessively or for prolonged periods, copper may no longer control the disease. Be sure to read and follow all label instructions of the product that you select to ensure that you use it in the safest and most effective manner possible.",

  "Tomato_Early_Blight": "Prune or stake plants to improve air circulation and reduce fungal problems. Make sure to disinfect your pruning shears (one part bleach to 4 parts water) after each cut. Keep the soil under plants clean and free of garden debris. Add a layer of organic compost to prevent the spores from splashing back up onto vegetation. Drip irrigation and soaker hoses can be used to help keep the foliage dry. For the best control, apply copper-based fungicides early, two weeks before disease normally appears or when weather forecasts predict a long period of wet weather. Alternatively, begin treatment when the disease first appears, and repeat every 7-10 days for as long as needed. Containing copper and pyrethrins, Bonide® Garden Dust is a safe, one-step control for many insect attacks and fungal problems. For best results, cover both the tops and undersides of leaves with a thin uniform film or dust. Depending on foliage density, 10 oz will cover 625 sq ft. Repeat applications every 7-10 days, as needed.",

  "Tomato_Late_Blight": "Sanitation is the first step in controlling tomato late blight. Clean up all debris and fallen fruit from the garden area. This is particularly essential in warmer areas where extended freezing is unlikely and the late blight tomato disease may overwinter in the fallen fruit. Currently, there are no strains of tomato available that are resistant to late tomato blight, so plants should be inspected at least twice a week. Since late blight symptoms are more likely to occur during wet conditions, more care should be taken during those times. For the home gardener, fungicides that contain maneb, mancozeb, chlorothanolil, or fixed copper can help protect plants from late tomato blight. Repeated applications are necessary throughout the growing season as the disease can strike at any time. For organic gardeners, there are some fixed copper products approved for use; otherwise, all infected plants must be immediately removed and destroyed.",

  "Tomato_Leaf_Mold": "When treating tomato plants with fungicide, be sure to cover all areas of the plant that are above the soil, especially the underside of leaves, where the disease often forms. Calcium chloride-based sprays are recommended for treating leaf mold issues. Organic fungicide options are also available.",

  "Tomato_Septoria_Leaf_Spot": "Remove diseased leaves. Improve air circulation around the plants. Mulch around the base of the plants. Mulching will reduce splashing soil, which may contain fungal spores associated with debris. Apply mulch after the soil has warmed. Do not use overhead watering. Overhead watering facilitates infection and spreads the disease. Use a soaker hose at the base of the plant to keep the foliage dry. Water early in the day. Control weeds. Nightshade and horsenettle are frequently hosts of Septoria leaf spot and should be eradicated around the garden site. Use crop rotation. Next year do not plant tomatoes back in the same location where diseased tomatoes grew. Wait 1–2 years before replanting tomatoes in these areas. Use fungicidal sprays.",

  "Tomato_Spider_Mites | Two-Spotted_Spider_Mite": "Avoid weedy fields and do not plant eggplant adjacent to legume forage crops. Avoid early-season, broad-spectrum insecticide applications for other pests. Do not over-fertilize. Overhead irrigation or prolonged periods of rain can help reduce populations.",

  "Tomato_Target_Spot": "Cultural control is important. The following should be done: Do not plant new crops next to older ones that have the disease. Plant as far as possible from papaya, especially if leaves have small angular spots. Check all seedlings in the nursery, and throw away any with leaf spots. Remove a few branches from the lower part of the plants to allow better airflow at the base. Remove and burn the lower leaves as soon as the disease is seen, especially after the lower fruit trusses have been picked. Keep plots free from weeds, as some may be hosts of the fungus. Do not use overhead irrigation; otherwise, it will create conditions for spore production and infection. Collect and burn as much of the crop as possible when the harvest is complete. Practice crop rotation, leaving 3 years before replanting tomato on the same land.",

  "Tomato_Yellow_Leaf_Curl_Virus": "Use only virus- and whitefly-free tomato and pepper transplants. Transplants should be treated with Capture (bifenthrin) or Venom (dinotefuran) for whitefly adults and Oberon for eggs and nymphs. Imidacloprid or thiamethoxam should be used in transplant houses at least seven days before shipping. Imidacloprid should be sprayed on the entire plant and below the leaves; eggs and flies are often found below the leaves. Spray every 14-21 days and rotate on a monthly basis with Abamectin so that the whiteflies do not build up resistance to chemicals.",

  "Tomato_Mosaic_Virus": "Use certified disease-free seed or treat your own seed. Soak seeds in a 10% solution of trisodium phosphate (Na3PO4) for at least 15 minutes. Or heat dry seeds to 158 °F and hold them at that temperature for two to four days. Purchase transplants only from reputable sources. Ask about the sanitation procedures they use to prevent disease. Inspect transplants prior to purchase. Choose only transplants showing no clear symptoms. Avoid planting in fields where tomato root debris is present, as the virus can survive long-term in roots. Wash hands with soap and water before and during the handling of plants to reduce potential spread between plants.",

  "Tomato_Healthy": "Healthy Tomato"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Disease Recognition'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Cure : ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Text(disease[diseaseName]!),
            ),
          ],
        ),
      ),
    );
  }
}