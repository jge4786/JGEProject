import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Dalla",
    product: .staticFramework,
    dependencies: [
        .project(target: "ThirdPartyLib", path: .relativeToRoot("Projects/ThirdPartyLib"))
    ],
    resources: ["Resources/**"]
)
