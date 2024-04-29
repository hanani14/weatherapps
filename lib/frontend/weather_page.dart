import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapps/main.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({super.key});

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUI();
  }

  fetchUI()async{
    Future.delayed(const Duration(seconds: 0)).then((_) async {
      await ref.read(weatherProvider).fetchData(true, '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, weatherProviders, child) {
       var provider = weatherProviders.watch(weatherProvider);
       Widget widget1 ;
       if(provider.isFetching){
        widget1 = const Scaffold(
          body: Center(
                child: CircularProgressIndicator(),
              ),
        );
       }
       else{
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(provider.getSysData['sunrise'] * 1000);
        String formattedDateSunrise = dateTime.toString();
        DateTime dateTimeSunset = DateTime.fromMillisecondsSinceEpoch(provider.getSysData['sunset'] * 1000);
        String formattedDateSunset = dateTimeSunset.toString();
          String formattedDateSunriseSeaarch = '',formattedDateSunsetSearch = '';
        if(provider.getSearchResponse.isNotEmpty){
          DateTime dateTimesearch = DateTime.fromMillisecondsSinceEpoch(provider.getSearchSysData['sunrise'] * 1000);
          formattedDateSunriseSeaarch = dateTimesearch.toString();
          DateTime dateTimeSunsetsearch = DateTime.fromMillisecondsSinceEpoch(provider.getSearchSysData['sunset'] * 1000);
          formattedDateSunsetSearch = dateTimeSunsetsearch.toString();
        }
        if(provider.failure != null ){
          widget1 = Scaffold(
          backgroundColor:Colors.red[100],
          body: SafeArea(
          bottom: false,
          child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment(0.8, 1.5),
                          colors: <Color>[
                            Color.fromARGB(255, 254, 199, 143),
                            Color(0xfff39060),
                            Color.fromARGB(255, 86, 88, 177),
                            Color.fromARGB(255, 75, 84, 211),
                            Color.fromARGB(255, 1, 37, 245),
                          ],
                          tileMode: TileMode.mirror,
                        ),
                      ),
            child: Column(
              children: [
                       Container(
                          color: Colors.white10,
                          child: TextField(
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                    },
                                    enabled: true,
                                    style:const TextStyle(fontSize: 12.0, color: Colors.black),
                                    controller: searchController,
                                    onSubmitted: (value)async {
                                        await ref.read(weatherProvider).fetchData(false, searchController.text);
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search,size: 23,),
                                        suffixIcon: searchController.text.isEmpty
                                            ? null
                                            : Container(
                                                margin: const EdgeInsets.all(12.0),
                                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey[300]),
                                                child: InkWell(
                                                  onTap: (){
                                                    searchController.clear();
                                                    fetchUI();
                                                  },
                                                  child: const Icon(
                                                    Icons.clear,
                                                    size: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              focusedErrorBorder: InputBorder.none,
                                              enabledBorder : InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Search',
                                        hintStyle:const TextStyle(fontSize: 12.0, color: Colors.grey)),
                            ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height *0.35,),
                        Text('${provider.failure}',textAlign: TextAlign.center,)
            ],),
          ),
                  )
                  );
        }else{
        widget1 = Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.orange,
        body: SafeArea(
          bottom: false,
          child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment(0.8, 1.5),
                          colors: <Color>[
                            Color.fromARGB(255, 254, 199, 143),
                            Color(0xfff39060),
                            Color.fromARGB(255, 86, 88, 177),
                            Color.fromARGB(255, 75, 84, 211),
                            Color.fromARGB(255, 1, 37, 245),
                          ],
                          tileMode: TileMode.mirror,
                        ),
                      ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Container(
                          color: Colors.white10,
                          child: TextField(
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                    },
                                    enabled: true,
                                    style:const TextStyle(fontSize: 12.0, color: Colors.black),
                                    controller: searchController,
                                    onSubmitted: (value)async {
                                        await ref.read(weatherProvider).fetchData(false, searchController.text);
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search,size: 23,),
                                        suffixIcon: searchController.text.isEmpty
                                            ? null
                                            : Container(
                                                margin: const EdgeInsets.all(12.0),
                                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey[300]),
                                                child: InkWell(
                                                  onTap: (){
                                                    searchController.clear();
                                                  },
                                                  child: const Icon(
                                                    Icons.clear,
                                                    size: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              focusedErrorBorder: InputBorder.none,
                                              enabledBorder : InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Search',
                                        hintStyle:const TextStyle(fontSize: 12.0, color: Colors.grey)),
                            ),
                        ),
                        const SizedBox(height: 15,),
                        Text('Current location: ${provider.getResponse['name']} ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700)),
                        const SizedBox(height: 5,),
                        Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:  Colors.white24,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(alignment: Alignment.center,child:Image.network('http://openweathermap.org/img/w/${provider.getWeatherData[0]["icon"]}.png',scale: 1/2,height: 70,) ,),
                                  Align(alignment: Alignment.center,child: Text('${provider.getWeatherData[0]['description']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),)),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                      Text('${provider.getWeatherData[0]['main']}', style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700)),
                                      const SizedBox(width: 10,),
                                      Text('${provider.getMainData['temp']}\u2103', style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700)),
                                    ],),
                                  const SizedBox(height: 20,),
                                  const SizedBox(height: 5,),
                                  Text('Sunrise: $formattedDateSunrise',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),
                                  Text('Sunset: $formattedDateSunset',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),
                                  const SizedBox(height: 10,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                    Text('Pressure: ${provider.getMainData['pressure']}hPa', style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),
                                    Text('Humidity: ${provider.getMainData['humidity']}%', style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),
                                    Text('Visibility: ${provider.getResponse['visibility']}m', style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),

                                  ],),
                                
                              ],),),
                        const SizedBox(height: 15,),
                        if(provider.getSearchResponse.isNotEmpty)
                        Text('Search location: ${provider.getSearchResponse['name']} ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700)),
                        const SizedBox(height: 5,),
                        if(provider.getSearchResponse.isNotEmpty)
                        Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:  Colors.white24,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(alignment: Alignment.center,child:Image.network('http://openweathermap.org/img/w/${provider.getSearchWeatherData[0]["icon"]}.png',scale: 1/2,height: 70,) ,),
                                  Align(alignment: Alignment.center,child: Text('${provider.getSearchWeatherData[0]['description']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),)),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                      Text('${provider.getSearchWeatherData[0]['main']}', style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700)),
                                      const SizedBox(width: 10,),
                                      Text('${provider.getSearchMainData['temp']}\u2103', style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700)),
                                    ],),
                                  const SizedBox(height: 20,),
                                  const SizedBox(height: 5,),
                                  Text('Sunrise: $formattedDateSunriseSeaarch',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),
                                  Text('Sunset: $formattedDateSunsetSearch',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),
                                  const SizedBox(height: 10,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                    Text('Pressure: ${provider.getSearchMainData['pressure']}hPa', style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),
                                    Text('Humidity: ${provider.getSearchMainData['humidity']}%', style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),
                                    Text('Visibility: ${provider.getSearchResponse['visibility']}m', style: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),

                                  ],),
                                
                              ],),),
                    
                
            ],),
          ),
        )
    );}}
    return widget1;});
  }
}