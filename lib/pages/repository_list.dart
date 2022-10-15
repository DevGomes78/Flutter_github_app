import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/api_repository.dart';
import '../controller/call_repository.dart';

class RepositoryList extends StatefulWidget {
  const RepositoryList({Key? key}) : super(key: key);

  @override
  State<RepositoryList> createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  ApiRepository apiRepository = ApiRepository();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    apiRepository = context.read<ApiRepository>();

    apiRepository.getRepository();
  }

  @override
  Widget build(BuildContext context) {
    ApiRepository providerRepository = Provider.of<ApiRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Repositorios'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 1),
        child: ListView.builder(
            itemCount: providerRepository.list.length,
            itemBuilder: (context, index) {
              var listRepository = providerRepository.list[index];
              return InkWell(
                onTap: CallRepository(repositoyModels: listRepository).callGithub,
                child: Card(
                  elevation: 5,
                  child: SizedBox(
                    height: 130,
                    width: 220,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listRepository.name.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            listRepository.description.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                             color: Colors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.yellow),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(listRepository.stargazersCount.toString()),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.lightBlue),
                              ),
                              const SizedBox(width: 10),
                              Text(listRepository.language.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
