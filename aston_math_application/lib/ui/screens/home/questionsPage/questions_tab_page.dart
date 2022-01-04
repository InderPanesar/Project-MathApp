import 'package:aston_math_application/engine/model/Questions/QuestionTopic.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questions_detail_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionsTabPageCubit/questions_tab_page_cubit.dart';
import 'package:aston_math_application/util/expandable_tile.dart';
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
  List<QuestionTopic> _topic = [];



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
                      _topic = state.questions;
                      return Container(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _topic.length,
                          itemBuilder: (context, index) {
                            return ExpandableTile(_topic[index]);
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