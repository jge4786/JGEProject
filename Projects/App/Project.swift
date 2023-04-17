
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "JGEProject",
    platform: .iOS,
    product: .app,
    dependencies: [
        .project(target: "Dalla", path: .relativeToRoot("Projects/Dalla")),
        .project(target: "Chat", path: .relativeToRoot("Projects/Chat")),
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
