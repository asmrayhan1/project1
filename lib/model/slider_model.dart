class SliderModel{
  String? image;
  String? title;
  String? description;

// Constructor for variables
  SliderModel({this.title, this.description, this.image});

  void setImage(String getImage){
    image = getImage;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDescription(String getDescription){
    description = getDescription;
  }

  String getImage(){
    return image!;
  }

  String getTitle(){
    return title!;
  }
  String getDescription(){
    return description!;
  }

  List<SliderModel> getSlides(){
    List<SliderModel> slides = [];
    SliderModel sliderModel = SliderModel();

    // Item 1
    sliderModel.setImage("assets/images/image1.png");
    sliderModel.setTitle("We Connect People");
    sliderModel.setDescription("Connecting people through one platform to share the memories together.");
    slides.add(sliderModel);

    sliderModel = SliderModel();

    // Item 2
    sliderModel.setImage("assets/images/image2.png");
    sliderModel.setTitle("Sharing Happiness");
    sliderModel.setDescription("Sharing happiness by sharing your memories in Zelio platform.");
    slides.add(sliderModel);

    sliderModel = SliderModel();

    // Item 3
    sliderModel.setImage("assets/images/image3.png");
    sliderModel.setTitle("Last Long Memories");
    sliderModel.setDescription("You can store memories of your photos in Zelio app without limit.");
    slides.add(sliderModel);

    sliderModel = SliderModel();
    return slides;
  }
}