import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../exports.dart';

class TasksView extends StatefulWidget {
  final Task? currentTask;
  Size? size;

  TasksView({Key? key, this.currentTask}) : super(key: key);

  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final TasksController controller = Get.put(TasksController());
  final GetStorage userData = GetStorage();

  @override
  void initState() {
    super.initState();
    if (widget.currentTask != null) {
      controller.task = widget.currentTask;
      controller.showCurrentTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.size = Get.size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 75, 7, 54),
        title: Text(
          AppConstants.taskTitle,
          style: appBarTextStyle.copyWith(fontSize: 25, color: Colors.white),
        ),
        actions: [
          widget.currentTask != null
              ? InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onTap: () => controller.confirmDelete(context),
                )
              : InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.clear, color: Colors.white),
                  ),
                  onTap: () => controller.confirmCancel(context),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: GetBuilder<TasksController>(
            builder: (controller) =>
                controller.isLoading ? const CircularProgress() : inputForm(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.saveTask();
        },
        backgroundColor: Color.fromARGB(255, 75, 7, 54),
        child: const Icon(Icons.save, color: AppColors.white),
      ),
    );
  }

  Widget inputForm() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Title',
              prefixIcon: const Icon(Icons.text_fields, color: Color.fromARGB(255, 75, 7, 54)),
            ),
            controller: controller.titleController!,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Description',
            ),
            controller: controller.contentController!,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'DueDate',
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, controller.dueDateController!),
              ),
            ),
            controller: controller.dueDateController!,
            keyboardType: TextInputType.datetime,
          ),
          ListTile(
            title: Text('Status'),
            iconColor: Color.fromARGB(255, 75, 7, 54),
            trailing: Switch(
              activeColor: Color.fromARGB(255, 75, 7, 54),
              value: controller.StatusController!.value,
              onChanged: (value) {
                print('Switch onChanged: $value');
                setState(() {
                  controller.StatusController!.value = value;
                });
                print('Switch value updated: ${controller.StatusController!.value}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = picked.toString(); // Update the controller with the selected date
    }
  }
}
