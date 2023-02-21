import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app/screens/my_screen/theme_card.dart';
import 'package:notes_app/services/firestore.dart';
import 'package:undo/undo.dart';

import '../../../services/auth.dart';
import '../../../services/models.dart';

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({required this.myNote});
  Notes myNote;
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  Color bgColor = Color(0xFFEBF6FC);
  Color textColor = Colors.lightBlue.shade800;

  List<dynamic> colors = [
    Colors.black.withOpacity(.7),
    Colors.pinkAccent.shade100,
    Colors.cyan.shade400,
    Colors.deepPurple.shade400,
    Colors.grey.shade800,
    Colors.lightBlue.shade800,
    Colors.redAccent.shade100,
    Colors.orangeAccent.shade200,
    Colors.greenAccent.shade200
  ];

  FocusNode _focusTitle = FocusNode();
  FocusNode _focusNote = FocusNode();
  //TextEditingController _controller = TextEditingController();
  bool focused = false;
  TextEditingController _noteController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  bool isRedo = false;
  late SimpleStack _redocontroller;
  late String note;
  late String title;
  late int characters;
  late String noteid;
  late bool isPublic; //default all notes are public
  late bool allowFullControl;

  @override
  void initState() {
    super.initState();

    _focusTitle.addListener(_onTitleChange);
    _focusNote.addListener(_onNoteChange);

    _redocontroller = SimpleStack<String>(
      "",
      limit: 50,
      onUpdate: (val) {},
    );

    setState(() {
      characters = widget.myNote.note.length;
      _noteController.value = TextEditingValue(
        text: widget.myNote.note,
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.myNote.note.length),
        ),
      );
      _titleController.text = widget.myNote.title;
      noteid = widget.myNote.noteid; // by default itll be empty
      textColor = Color(int.parse(widget.myNote.color));
      isPublic = widget.myNote.isPublic;
    });
    title = widget.myNote.title;
    note = widget.myNote.note;
    checkStatus();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _titleController.dispose();
    _focusTitle.removeListener(_onTitleChange);
    _focusTitle.dispose();
    _focusNote.removeListener(_onNoteChange);
    _focusNote.dispose();

    super.dispose();
  }

  void checkStatus(){

    if (noteid == ""){ //
      allowFullControl = true;
      return;
    }
    if( widget.myNote.uid == AuthService().user?.uid){ //current user owns this note
      allowFullControl = true;
      return;
    }
    allowFullControl = false;
  }

  void _onTitleChange() {
    _focusTitle.hasFocus ? focused = true : focused = false;
    setState(() {});
  }

  void _onNoteChange() {
    _focusNote.hasFocus ? focused = true : focused = false;
    setState(() {});
  }

  Future<void> _clickBtn() async {
    //tick button
    log("end function");
    try {
      _focusTitle.unfocus();
      _focusNote.unfocus();
      focused = false;

      if (title == "" && note == "") {
        log("null case");
        return;
      }
      if (noteid == "") {
        //first generate a document
        log("Create function");
        String nid =
            FirestoreService().addNote(title, note, textColor.value.toString(), isPublic);
        setState(() {
          noteid = nid;
        });
      } else {
        log("Update function");
        FirestoreService()
            .updateNote(title, note, textColor.value.toString(), noteid, isPublic);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _undoBtn() {
    isRedo = true;
    setState(() {
      _redocontroller.undo();
      String val = _redocontroller.state;
      characters = val.length;
      _noteController.value = TextEditingValue(
        //
        text: val,
        selection: TextSelection.fromPosition(
          TextPosition(offset: val.length),
        ),
      );
    });
  }

  void _redoBtn() {
    setState(() {
      isRedo = true;
      setState(() {
        _redocontroller.redo();
        String val = _redocontroller.state;
        characters = val.length;
        _noteController.value = TextEditingValue(
          text: val,
          selection: TextSelection.fromPosition(
            TextPosition(offset: val.length),
          ),
        );
      });
    });
  }

  List<Widget> _getActiveItems() {
    return _focusNote.hasFocus == true
        ? [
            GestureDetector(
              onTap: _undoBtn,
              child: Icon(Icons.undo, color: textColor),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: _redoBtn,
              child: Icon(Icons.redo, color: textColor),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: _clickBtn,
              child: Icon(Icons.check, color: textColor),
            ),
            const SizedBox(
              width: 10,
            ),
          ]
        : [
            GestureDetector(
              onTap: _clickBtn,
              child: Icon(Icons.check, color: textColor),
            ),
            const SizedBox(
              width: 10,
            ),
          ];
  }
  List<Widget> _getInactiveItems(){
    return [
      GestureDetector(
        child: Icon(
          Icons.tag_faces,
          color: textColor,
        ),
        onTap: () {
          ThemesModalBottomSheet(context);
        },
      ),
      const SizedBox(
        width: 20,
      ),
      Icon(Icons.star, color: textColor),
      const SizedBox(
        width: 20,
      ),
      isPublic == true?
      GestureDetector(
        onTap: (){
          setState(() {
            isPublic = false;
          });
          FirestoreService().updateNotePrivacy(noteid, isPublic);
        },
        child: Icon(
          Icons.public,
          color: textColor,
        ),
      ):
      GestureDetector(
        onTap: (){
          setState(() {
            isPublic = true;
          });
          FirestoreService().updateNotePrivacy(noteid, isPublic);
        },
        child: Icon(
          Icons.public_off,
          color: textColor,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> LM  = [
      Text(
        "${widget.myNote.datecreated} | $characters characters",
        style: TextStyle(
          color: textColor.withOpacity(.6),
          fontSize: 12,
          fontFamily: "Poppins",
        ),
      ),
    ];
    if (widget.myNote.lastupdated != ""){
      LM.add(
          Text(
              "Last Modified: ${widget.myNote.lastupdated}",
              style: TextStyle(
                color: textColor.withOpacity(.6),
                fontSize: 11,
                fontFamily: "Poppins",
              ),
            )
      );
    }

    return WillPopScope(
      onWillPop: () {
        if (focused == true) {
          _clickBtn();
          return Future.value(false);
        } else {

          if(widget.myNote.uid == AuthService().user?.uid || widget.myNote.noteid == ""){
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); //home screen
            Navigator.pushNamed(context, '/my');
          }
          else{
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); //home screen
          }
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: allowFullControl == true?
        AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          leading: GestureDetector(
            onTap: (){
              if (focused == true) {
                _clickBtn();
              } else {

                if(widget.myNote.uid == AuthService().user?.uid || widget.myNote.noteid == ""){
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); //home screen
                  Navigator.pushNamed(context, '/my');
                }
                else{
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); //home screen
                }
                //Navigator.pop(context);
              }
            },
            child: Icon(
              Icons.arrow_back,
              color: textColor,
            ),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: focused == false
                  ? _getInactiveItems()
                  : _getActiveItems(),
            ),
          ),
        ): AppBar(
          backgroundColor: textColor,
        ),
        backgroundColor: bgColor,
        body: Padding(
          padding: EdgeInsets.only(top: 0, left: 15.0, right: 15, bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Insert Title",
                    hintStyle: TextStyle(
                        color: textColor.withOpacity(.5), fontSize: 30),
                  ),
                  style: TextStyle(
                      color: textColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                  onChanged: (tit) {
                    title = tit;
                  },
                  autofocus: false,
                  focusNode: _focusTitle,
                  controller: _titleController,
                  enabled: allowFullControl == true? true: false,

                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: LM,
                ),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Insert your message",
                          hintStyle: TextStyle(
                              color: textColor.withOpacity(.5), fontSize: 16),
                        ),
                        scrollPadding: const EdgeInsets.all(20.0),
                        keyboardType: TextInputType.multiline,
                        maxLines: 99999,
                        autofocus: false,
                        style: TextStyle(
                          color: textColor.withOpacity(.9),
                          fontSize: 16,
                        ),
                        onChanged: (s) {
                          if (isRedo == true) {
                            isRedo = false;
                            return;
                          }
                          //log(s);
                          note = s;
                          setState(() {
                            characters = s.length;
                          });
                          _redocontroller.modify(s);
                        },
                        focusNode: _focusNote,
                        controller: _noteController,
                        enabled: allowFullControl == true? true: false,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> ThemesModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 3.8,
          color: bgColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Row(
                  children: colors
                      .map(
                        (e) => ThemeCard(
                          textColor: e,
                          isSelected: textColor,
                          onTap: () {
                            textColor = e;
                            setModalState(() {});
                            setState(() {});
                            //store note theme in firestore
                            FirestoreService().updateNoteColor(noteid, textColor.value.toString());
                          },
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
