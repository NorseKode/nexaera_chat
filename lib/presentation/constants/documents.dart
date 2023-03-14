import 'package:flutter/widgets.dart';

import '../components/paragraph_text.dart';
import '../components/section.dart';

enum Document { introduction, quickstart }

extension DocumentExtension on Document {
  String get displayName => displayNames[this] ?? 'Undefined';
  List<Section> get content => contents[this] ?? [];

  static const displayNames = {
    Document.introduction: 'Introduction',
    Document.quickstart: 'Quickstart'
  };

//Should be changed to retrieve from database instead
  static const contents = {
    Document.introduction: [
      Section(title: 'Overview', content: [
        Paragraph(
          "Nexæra is a SaaS solution that provides a customizable chatbot interface for companies to use based on their own data. With Nexæra, companies can create a chatbot that can answer customer questions, provide product recommendations, and offer personalized solutions. The chatbot interface can be easily integrated into the company's website or app, providing customers with a seamless experience.",
        ),
      ]),
      Section(title: 'Token', content: [
        Paragraph("test"),
      ]),
      Section(title: 'AI capabilities', content: [
        Paragraph(
            "Our AI is a cutting-edge AI chatbot that can help your company gain valuable insights from your data. It can work with structured and unstructured data, including text, images, and numerical data, and is trained on a variety of industries and domains. Our AI can provide insights on topics such as customer behavior, market trends, and product performance using your own company data. With its powerful natural language processing capabilities, Our AI can understand and respond to your queries in a conversational manner, making it easy to get the insights you need. Whether you need to analyze customer feedback, monitor social media sentiment, or make data-driven decisions, Our AI is here to help you.")
      ])
    ],
  };
}
