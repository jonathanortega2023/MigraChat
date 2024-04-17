import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:getwidget/components/tabs/gf_segment_tabs.dart';
import 'package:getwidget/getwidget.dart';
import 'package:migra_chat/src/models/government_form.dart';
import 'package:migra_chat/src/ui/widgets.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({super.key});

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Forms'),
      ),
      body: Expanded(
          child: Column(
        children: [
          const Divider(
            height: 5,
          ),
          // TabBar for TODO | Pending | Processed
          GFSegmentTabs(
            height: 50,
            width: MediaQuery.of(context).size.width,
            length: 4,
            indicator: const BoxDecoration(color: Colors.transparent),
            tabBarColor: Colors.white,
            labelColor: Colors.black,
            labelStyle: const TextStyle(fontSize: 18),
            unselectedLabelColor: Colors.black45,
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            labelPadding: EdgeInsets.zero,
            border: Border.all(color: Colors.black, width: 0),
            tabs: [
              const Tab(
                child: Text('TODO'),
              ),
              const Tab(
                child: Text('Pending'),
              ),
              const Tab(
                child: Text('Processed'),
              ),
              const Tab(
                child: Text('All Forms'),
              ),
            ],
            tabController: _tabController,
          ),
          // Accordion for category of document
          Expanded(
            child: GFTabBarView(children: [
              Container(
                color: Colors.yellow,
              ),
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.green,
              )
            ], controller: _tabController),
          )
        ],
      )),
    );
  }
}

class FormAccordion extends StatelessWidget {
  final ImmigrationForm formInfo;

  const FormAccordion({super.key, required this.formInfo});

  @override
  Widget build(BuildContext context) {
    return GFAccordion(
      title: formInfo.codeName + ' | ' + formInfo.fullName,
      contentChild: Column(
        children: [
          Text(formInfo.shortDescription),
          Row(
            children: [
              GFButton(
                onPressed: () {},
                text: 'View More',
                icon: const Icon(Icons.info),
              ),
              GFButton(
                onPressed: () {},
                text: 'Start Form',
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FormCategoryAccordion extends StatelessWidget {
  FormCategoryAccordion(
      {super.key, required this.category, required this.forms});

  final String category;
  final List<ImmigrationForm> forms;

  @override
  Widget build(BuildContext context) {
    return GFAccordion(
      title: category,
      contentChild: Column(
        children: forms.map((form) => FormAccordion(formInfo: form)).toList(),
      ),
    );
  }
}
