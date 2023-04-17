import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Chat",
    product: .staticFramework,
    dependencies: [
        .project(target: "ThirdPartyLib", path: .relativeToRoot("Projects/ThirdPartyLib"))
    ],
    resources: ["Resources/**"]
)
