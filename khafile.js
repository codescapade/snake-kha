let project = new Project('Kha Snake');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');
project.windowOptions.width = 640;
project.windowOptions.height = 480;
// project.addParameter('-dce full');
resolve(project);
