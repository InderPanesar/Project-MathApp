import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionsTabPageCubit/questions_tab_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class QuestionTabPage extends StatefulWidget {
  @override
  _QuestionTabPageState createState() => _QuestionTabPageState();
}

class _QuestionTabPageState extends State<QuestionTabPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  QuestionTabPageCubit _bloc = GetIt.instance();
  Map<String, dynamic>? _map;



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: Text("Questions", style: TextStyle(fontSize: 32, color: Colors.white),),
                          padding: EdgeInsets.fromLTRB(20,60,20,40)
                      ),
                      Spacer()
                    ],
                  ),
                  color: Colors.deepPurple,
                ),
                BlocBuilder<QuestionTabPageCubit, QuestionTabPageState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if(state is QuestionTabPageStateFailed) return Spacer(); //ToDo: Implement Error State
                    if (state is QuestionTabPageStateLoading) {
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }
                    if(state is QuestionTabPageStateSuccess) {
                      _map = state.questions;
                      var newList = _map!.keys.toList();
                      return Container(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: newList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              color: Colors.deepPurple,
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  print('Card tapped. Code: ' + _map![newList[index]]);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Row(
                                        children: [
                                          Text(newList[index], style: TextStyle(fontSize: 20, color: Colors.white),),
                                          Spacer(),
                                          Icon(
                                              Icons.arrow_right,
                                              color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    else return Spacer();

                  },

                )
              ]
          )
      ),
    );
  }
}