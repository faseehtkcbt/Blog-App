import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/widgets/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/app_text.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image;
  List<String> selectedTopics = [];
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      image = pickedImage;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: DottedBorder(
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    color: AppPallete.borderColor,
                    dashPattern: const [10, 4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                AppText(
                                  text: "Select the image",
                                  txtSize: 25,
                                )
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Programming', 'Business', 'Entertainment']
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    selectedTopics.contains(e)
                                        ? selectedTopics.remove(e)
                                        : selectedTopics.add(e);
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: AppText(text: e),
                                    backgroundColor: selectedTopics.contains(e)
                                        ? AppPallete.gradient1
                                        : null,
                                    side: selectedTopics.contains(e)
                                        ? const BorderSide(
                                            color: AppPallete.borderColor)
                                        : null,
                                  ),
                                ),
                              ))
                          .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlogEditter(
                  controller: titleController,
                  hintText: 'Blog'
                      ' Editter'),
              SizedBox(
                height: 10,
              ),
              BlogEditter(
                  controller: descriptionController, hintText: 'Blog Content')
            ],
          ),
        ),
      ),
    );
  }
}
