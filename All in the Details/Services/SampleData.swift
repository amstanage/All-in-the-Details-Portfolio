import Foundation

/// Portfolio data from @nardussy — film photography featuring automotive, architecture, and street work
struct SampleData {
    
    static let filmExif = EXIFData(
        camera: "Contax G2",
        lens: "Carl Zeiss Planar 45mm f/2",
        focalLength: "45mm",
        aperture: "f/2",
        shutterSpeed: "1/500s",
        iso: "ISO 400",
        dateTaken: nil
    )
    
    static let digitalExif = EXIFData(
        camera: "Leica Q2",
        lens: "Summilux 28mm f/1.7",
        focalLength: "28mm",
        aperture: "f/1.7",
        shutterSpeed: "1/2000s",
        iso: "ISO 100",
        dateTaken: nil
    )
    
    static let spacePhotos: [Photo] = [
        // RS6 Exterior — on location (glass building)
        Photo(
            title: "Glass & Lines",
            caption: "Geometric glass facade framing the Nardo Grey RS6 Avant. Architecture meets automotive.",
            tags: ["rs6", "audi", "nardo-grey", "film"],
            category: .automotive,
            imageName: "002545590001",
            exif: filmExif,
            sortOrder: 0
        ),
        Photo(
            title: "Front Quarter",
            caption: "Aggressive stance — the RS6 Avant against reflective glass, low angle catching the honeycomb grille.",
            tags: ["rs6", "audi", "avant", "film"],
            category: .automotive,
            imageName: "002545590002",
            exif: filmExif,
            sortOrder: 1
        ),
        Photo(
            title: "Under the Oak",
            caption: "RS6 rear three-quarter framed by a towering oak. Summer light on Nardo Grey paint.",
            tags: ["rs6", "audi", "rear", "film"],
            category: .automotive,
            imageName: "002545590003",
            exif: filmExif,
            sortOrder: 2
        ),
        Photo(
            title: "Departure",
            caption: "Wide rear shot capturing the broad shoulders and quad exhaust of the RS6 Avant.",
            tags: ["rs6", "audi", "rear", "wide"],
            category: .automotive,
            imageName: "002545590004",
            exif: filmExif,
            sortOrder: 3
        ),
        Photo(
            title: "Side Profile",
            caption: "Full-length side view of the RS6 Avant — long roof, wide hips, red calipers peeking through.",
            tags: ["rs6", "audi", "profile", "film"],
            category: .automotive,
            imageName: "002545590005",
            exif: filmExif,
            sortOrder: 4
        ),
        Photo(
            title: "Driver's Side",
            caption: "The RS6 profiled against glass panels, yellow bollard anchoring the foreground.",
            tags: ["rs6", "audi", "side", "film"],
            category: .automotive,
            imageName: "002545590006",
            exif: filmExif,
            sortOrder: 5
        ),
        Photo(
            title: "Perfect Profile",
            caption: "Clean driver's side profile — the proportions of the C8 RS6 Avant at their best.",
            tags: ["rs6", "audi", "profile", "film"],
            category: .automotive,
            imageName: "002545590007",
            exif: filmExif,
            sortOrder: 6
        ),
        Photo(
            title: "Wide Angle",
            caption: "Stepped back to take in the full scene — RS6, glass architecture, and summer sky.",
            tags: ["rs6", "audi", "wide", "architecture"],
            category: .automotive,
            imageName: "002545590008",
            exif: filmExif,
            sortOrder: 7
        ),
        Photo(
            title: "Portrait Mode",
            caption: "Vertical composition — the RS6's profile against the layered geometry of the building.",
            tags: ["rs6", "audi", "vertical", "film"],
            category: .automotive,
            imageName: "002545590009",
            exif: filmExif,
            sortOrder: 8
        ),
        
        // Street / Urban
        Photo(
            title: "Drive-Through",
            caption: "Golden hour at the drive-through — warm light catching a minivan and suburban architecture.",
            tags: ["street", "golden-hour", "suburban", "film"],
            category: .street,
            imageName: "002545590011",
            exif: filmExif,
            sortOrder: 9
        ),
        Photo(
            title: "Storm Brewing",
            caption: "Dramatic clouds building over a white brick building at dusk. Film grain adds texture to the sky.",
            tags: ["clouds", "dusk", "urban", "film"],
            category: .street,
            imageName: "002545590012",
            exif: filmExif,
            sortOrder: 10
        ),
        
        // Detail / Interior
        Photo(
            title: "Honeycomb Stitch",
            caption: "RS6 sport seat detail — honeycomb quilted leather with red contrast stitching. A film camera rests on the passenger side.",
            tags: ["rs6", "interior", "detail", "leather"],
            category: .detail,
            imageName: "002545590013",
            exif: filmExif,
            sortOrder: 11
        ),
        
        // Still Life
        Photo(
            title: "Soda Shop",
            caption: "Pepsi Soda Shop can in warm ambient light. Shallow depth of field, film bokeh.",
            tags: ["still-life", "pepsi", "film", "bokeh"],
            category: .stillLife,
            imageName: "002545590014",
            exif: filmExif,
            sortOrder: 12
        ),
        Photo(
            title: "Cracker Jack",
            caption: "A bag of Cracker Jacks — the kind of everyday subject that film makes feel nostalgic.",
            tags: ["still-life", "snacks", "film", "texture"],
            category: .stillLife,
            imageName: "002545590015",
            exif: filmExif,
            sortOrder: 13
        ),
        
        // Street / Landscape
        Photo(
            title: "Power Lines",
            caption: "Suburban treeline under cumulus clouds, bisected by a single power line. Quiet Midwest afternoon.",
            tags: ["suburban", "sky", "trees", "film"],
            category: .landscape,
            imageName: "002545590016",
            exif: filmExif,
            sortOrder: 14
        ),
        
        // RS6 Detail shots
        Photo(
            title: "Grille Badge",
            caption: "The RS6 badge nestled in the honeycomb grille — gloss black on Nardo Grey.",
            tags: ["rs6", "badge", "detail", "grille"],
            category: .detail,
            imageName: "002545590019",
            exif: filmExif,
            sortOrder: 15
        ),
        Photo(
            title: "Front Fascia",
            caption: "Close-up of the RS6 grille and Audi four rings. The RS badge in red catches the eye.",
            tags: ["rs6", "audi", "grille", "detail"],
            category: .detail,
            imageName: "002545590020",
            exif: filmExif,
            sortOrder: 16
        ),
        Photo(
            title: "Orange RS",
            caption: "Audi RS orange ceramic brake caliper framed by the forged five-spoke wheel.",
            tags: ["rs6", "brakes", "wheel", "detail"],
            category: .detail,
            imageName: "002545590021",
            exif: filmExif,
            sortOrder: 17
        ),
        Photo(
            title: "Four Rings Up Close",
            caption: "RS6 front grille head-on — the Audi emblem flanked by the RS badge. Garage light.",
            tags: ["rs6", "audi", "front", "detail"],
            category: .detail,
            imageName: "002545590022",
            exif: filmExif,
            sortOrder: 18
        ),
        Photo(
            title: "Four Rings",
            caption: "Head-on symmetry — the Audi honeycomb grille filling the frame. Garage portrait.",
            tags: ["rs6", "audi", "grille", "symmetry"],
            category: .detail,
            imageName: "002545590023",
            exif: filmExif,
            sortOrder: 19
        ),
        Photo(
            title: "Behind the Wheel",
            caption: "RS6 flat-bottom steering wheel through the driver's window. Warm afternoon light.",
            tags: ["rs6", "interior", "steering", "film"],
            category: .detail,
            imageName: "002545590024",
            exif: filmExif,
            sortOrder: 20
        ),
        Photo(
            title: "RS5HEAD",
            caption: "The vanity plate says it all — Audi four rings in black on the RS6 tailgate.",
            tags: ["rs6", "plate", "rear", "badge"],
            category: .detail,
            imageName: "002545590026",
            exif: filmExif,
            sortOrder: 21
        ),
        Photo(
            title: "RS6 Badge",
            caption: "Rear RS6 emblem in black — the Audi Sport logo in red. Clean lines on Nardo Grey.",
            tags: ["rs6", "badge", "rear", "detail"],
            category: .detail,
            imageName: "002545590027",
            exif: filmExif,
            sortOrder: 22
        ),
        
        // Dark RS6 (different car — black)
        Photo(
            title: "Dark Side",
            caption: "A black RS6 in a driveway — forged wheels catching the afternoon sun.",
            tags: ["rs6", "black", "wheel", "driveway"],
            category: .automotive,
            imageName: "002545590028",
            exif: filmExif,
            sortOrder: 23
        ),
        Photo(
            title: "Orange Calipers",
            caption: "Grey RS6 front wheel — five-spoke forged design with RS ceramic brakes in orange.",
            tags: ["rs6", "brakes", "wheel", "detail"],
            category: .detail,
            imageName: "002545590029",
            exif: filmExif,
            sortOrder: 24
        ),
        Photo(
            title: "Headlight",
            caption: "RS6 headlight and grille detail — LED matrix light signature with the RS badge below.",
            tags: ["rs6", "headlight", "detail", "film"],
            category: .detail,
            imageName: "002545590030",
            exif: filmExif,
            sortOrder: 25
        ),
        Photo(
            title: "Grille Portrait",
            caption: "Tight crop on the RS6 grille and headlight — aggression in every line.",
            tags: ["rs6", "grille", "portrait", "detail"],
            category: .detail,
            imageName: "002545590031",
            exif: filmExif,
            sortOrder: 26
        ),
        Photo(
            title: "Face to Face",
            caption: "RS6 dead-on from the garage floor. Symmetrical menace.",
            tags: ["rs6", "front", "symmetry", "garage"],
            category: .automotive,
            imageName: "002545590032",
            exif: filmExif,
            sortOrder: 27
        ),
        
        // Architecture / Landscape
        Photo(
            title: "Through the Fence",
            caption: "A canal scene glimpsed through a bridge opening — willows and still water on film.",
            tags: ["water", "landscape", "bridge", "film"],
            category: .landscape,
            imageName: "002545590033",
            exif: filmExif,
            sortOrder: 28
        ),
        Photo(
            title: "Behind the Gate",
            caption: "Ornate wrought iron gates framing the Belle Isle Conservatory dome.",
            tags: ["detroit", "belle-isle", "conservatory", "architecture"],
            category: .architecture,
            imageName: "002545590034",
            exif: filmExif,
            sortOrder: 29
        ),
        Photo(
            title: "Conservatory",
            caption: "The Anna Scripps Whitcomb Conservatory at Belle Isle, framed by mature trees and iron gates.",
            tags: ["detroit", "belle-isle", "conservatory", "film"],
            category: .architecture,
            imageName: "002545590035",
            exif: filmExif,
            sortOrder: 30
        ),
        Photo(
            title: "The Tower",
            caption: "A stone bell tower rising above autumn foliage and overcast skies.",
            tags: ["tower", "architecture", "autumn", "film"],
            category: .architecture,
            imageName: "002545590036",
            exif: filmExif,
            sortOrder: 31
        ),
        Photo(
            title: "Light Leak",
            caption: "Happy accident — a film light leak bisects a suburban street scene. Orange bleeds into stormy sky.",
            tags: ["light-leak", "film", "accident", "abstract"],
            category: .abstract,
            imageName: "002545590037",
            exif: filmExif,
            sortOrder: 32
        ),
        
        // Leica digital shots (L100xxxx)
        Photo(
            title: "Red Glow",
            caption: "RS6 taillight detail — the LED chevron pattern illuminated in deep red.",
            tags: ["rs6", "taillight", "detail", "led"],
            category: .detail,
            imageName: "L1001243",
            exif: digitalExif,
            sortOrder: 33
        ),
        Photo(
            title: "Matrix LED",
            caption: "RS6 headlight close-up — the layered LED signature and honeycomb grille texture.",
            tags: ["rs6", "headlight", "led", "detail"],
            category: .detail,
            imageName: "L1001244",
            exif: digitalExif,
            sortOrder: 34
        ),
        Photo(
            title: "Four Rings Macro",
            caption: "The Audi four rings in gloss black, shot macro — reflections of sky in chrome.",
            tags: ["audi", "rings", "macro", "emblem"],
            category: .detail,
            imageName: "L1001245",
            exif: digitalExif,
            sortOrder: 35
        ),
        Photo(
            title: "RS Caliper",
            caption: "Red RS brake caliper behind the wheel spokes — stopping power on display.",
            tags: ["rs6", "brakes", "caliper", "detail"],
            category: .detail,
            imageName: "L1001242",
            exif: digitalExif,
            sortOrder: 36
        ),
    ]
    
    static let collections: [PhotoCollection] = [
        PhotoCollection(
            name: "RS6 Avant — On Location",
            description: "The Nardo Grey RS6 Avant shot on film against glass architecture. Full exterior coverage.",
            coverPhotoID: spacePhotos[4].id,
            photoIDs: Array(spacePhotos[0...8]).map(\.id)
        ),
        PhotoCollection(
            name: "Detail Shots",
            description: "Badges, brakes, grilles, and interiors. The details that define the RS6.",
            coverPhotoID: spacePhotos[16].id,
            photoIDs: spacePhotos.filter { $0.category == .detail }.map(\.id)
        ),
        PhotoCollection(
            name: "Street & Architecture",
            description: "Film snapshots of urban scenes, landmarks, and the spaces between.",
            coverPhotoID: spacePhotos[29].id,
            photoIDs: spacePhotos.filter { $0.category == .street || $0.category == .architecture || $0.category == .landscape || $0.category == .abstract || $0.category == .stillLife }.map(\.id)
        ),
    ]
    
    static let profile = PhotographerProfile(
        name: "nardussy",
        bio: "Shooting on film. Cars, architecture, and everything in between. Based in the Midwest. Nardo Grey enthusiast.",
        profileImageName: "profile_photo",
        website: "https://instagram.com/nardussy",
        email: "",
        socialLinks: [
            SocialLink(platform: .instagram, url: "https://instagram.com/nardussy"),
        ]
    )
}
