import Alamofire
import Foundation

func vnefajAiCall(_ vnefajxSendText: String) async throws -> Data {

    let params: [String: Any] = [
        "dashScopeMessageDTOList": [
            [
                "role": "user",
                "content": vnefajxSendText
            ]
        ]
    ]

    let response = await AF.request(
        "https://api.wklk.link/api/dash/scope/textIssues",
        method: .post,
        parameters: params,
        encoding: JSONEncoding.default
    )
    .validate()
    .serializingData()
    .response

    switch response.result {
    case .success(let data):
        return data
    case .failure(let error):
        throw error
    }
}

struct AiResponse: Decodable {
  let result: AiResult
}

struct AiResult: Decodable {
  let output: AiOutput
}

struct AiOutput: Decodable {
  let choices: [AiChoice]
}

struct AiChoice: Decodable {
  let message: AiMessage
}

struct AiMessage: Decodable {
  let content: String
}

let venzcjaScritpList: [String] =
[
"""
The morning fog has not yet lifted, and the coastline drifts in and out of view beneath a cold blue sky. Waves crash against the rocks in a slow, deliberate rhythm, each impact echoing like a heartbeat announcing the beginning of a journey. On the edge of the cliff, Aria stands alone. Her cloak snaps violently in the wind, framing a figure that looks fragile at first glance, yet refuses to bend.

She lowers her gaze to the worn compass in her palm. The needle trembles, uncertain, as if it too understands the danger ahead. For a moment, the world seems to hold its breath. Then Aria closes her fingers around the compass and looks up. Her eyes cut across the restless sea toward a horizon no one has dared to cross in years. Fear flickers briefly in her expression, but it does not stay. Courage settles in its place, quiet and unyielding.

The scene shifts as she descends from the cliff into a dense forest, where towering trees block out the sky and the air smells of damp earth and old secrets. Sunlight filters through the leaves in broken shards, dancing across her path as she moves forward without hesitation. Every sound—a snapping twig, a distant call—tests her resolve, yet her steps never slow. This forest has claimed many before her, but it will not claim her.

By nightfall, firelight flickers against her determined face as she sits alone beside a small campfire. Shadows stretch and twist across the ground, mirroring the doubts she refuses to voice. She tightens the straps of her worn boots, rises to her feet, and looks once more into the darkness beyond the flames. Tomorrow, the path will grow steeper, the dangers more real—but so will her purpose.

Without looking back, Aria steps forward, carrying her bravery with her into the unknown, as the screen fades to black and the sound of the wind blends into silence.
""",

"""
The café is small and a little too bright, the kind of place where the chalkboard menu leans crooked and the espresso machine hisses like it’s gossiping about everyone inside. Morning sunlight spills through the window and lands directly on the counter, illuminating a chaotic lineup of pastries that clearly lost a fight with gravity.

Emma stands behind the register, smiling apologetically at a customer while trying to untangle a receipt that has somehow wrapped itself around her wrist. Her kindness is effortless, almost instinctive—she thanks people too much, laughs too easily, and insists on calling everyone “love,” even strangers who look mildly confused by it.

At exactly that moment, Daniel bursts through the door.

He doesn’t so much enter the café as collide with it. The bell rings violently, his foot slips on the welcome mat, and his coffee—freshly purchased from somewhere else—launches into the air in a slow, dramatic arc before landing squarely on his own shirt.

There is a beat of silence.

Then Emma gasps, rushes around the counter, and hands him a stack of napkins so large it could qualify as emergency supplies.
“Oh no—are you okay? I mean, obviously not okay okay, but like… emotionally?”

Daniel looks down at his soaked shirt, then back up at her. He starts laughing. Not politely. Fully, helplessly, like this is the best thing that’s happened all day.
“I’ve only been awake for ten minutes,” he says. “And I think this is a record.”

Emma laughs too, relieved, wiping the counter even though it’s perfectly clean.
“Well,” she says warmly, “the good news is, you’ve come to the right place to recover from personal disasters.”

She offers him a free coffee. He insists on paying. She refuses. He tries again. She wins.

As she makes the drink, they talk—about nothing important and everything that feels oddly comfortable. He jokes about being cursed by beverages. She admits she once spilled soup on a date before sitting down. Their laughter overlaps, clumsy and sincere, filling the café like background music.

When she hands him the coffee, their fingers brush. It’s brief. It’s accidental. It’s enough.

Daniel clears his throat, suddenly shy.
“So… if I come back tomorrow,” he says, “do you think I’ll survive the entrance?”

Emma smiles, kind and bright, already knowing the answer.
“I’ll keep the napkins ready,” she says.
""",

"""
Neon lights streak across the rain-soaked streets as the city hums with electric tension. Above it all, a drone squad locks onto its target—Lena.

She runs, breath steady, eyes sharp. Her fingers fly over a wrist-mounted console, decoding signals mid-sprint.
“Predictable,” she mutters, spotting the pattern in the drones’ movements.

A laser blasts the pavement where she stood a second ago. Lena slides behind a steel barrier, reroutes a power grid with three swift commands, and the street lights explode into darkness. The drones hesitate—just long enough.

She leaps out, firing an EMP pulse. Sparks rain from the sky as machines drop lifelessly around her.

Lena straightens, rain dripping from her jacket, already analyzing the next threat.
“System intelligence beats brute force,” she says calmly, disappearing into the shadows.
""",

"""
Candlelight trembles along the stone walls of the palace corridor, casting long shadows that move like secrets. Silk rustles softly as Lady Elara glides forward, her expression gentle, her eyes calculating. To anyone watching, she is grace itself—a noblewoman out for a midnight walk. In truth, every step is deliberate.

At the far end, Lord Matthias waits beneath an archway, clad in dark velvet, his posture relaxed yet alert. He smiles when he sees her, a smile born as much of desire as of suspicion.
“You risk much by coming,” he murmurs.

Elara tilts her head, feigning innocence, and steps closer.
“History favors the bold,” she replies softly, fingers brushing his sleeve as if by chance. The touch lingers just long enough to disarm him.

They speak of poetry and alliances, of past wars and fragile peace, their words layered with meaning. Beneath the romance, a quiet battle unfolds—each glance a test, each compliment a strategy. Elara listens more than she speaks, drawing out his ambitions, storing every confession behind her calm smile.

As bells toll in the distance, she leans in, her voice warm and intimate.
“Trust,” she whispers, “is the most powerful weapon.”

Matthias believes she means love.
Elara already knows she has won.
""",

"""
Neon starlight spills across the floating spires of Aerion Prime, where ancient runes glow beside humming holograms. At the center of the sky-bridge stands Lumo, a robed mage with a plasma-powered staff and a grin that suggests he’s never taken a prophecy seriously in his life.

A colossal dragon-drone descends, wings crackling with blue electricity. Its voice booms like a corrupted system alert.
“IDENTIFY YOURSELF, ORGANIC LIFEFORM.”

Lumo squints up at it. “Wow. Dragons used to just roar. Now they sound like customer support.”

The dragon-drone fires a beam. Lumo ducks, muttering a spell that manifests as a shimmering force field shaped suspiciously like a cartoon shield. The blast ricochets, slicing through a nearby tower.

“Hey!” Lumo shouts. “That tower was historic. And haunted. Now the ghosts are going to be very annoyed.”

He taps his staff; ancient glyphs spin into digital code, rewriting reality for a split second. The dragon-drone freezes midair, its eyes flickering.

Lumo strolls beneath it, looking up. “Let me guess—evil AI fused with mythical beast, trying to ‘optimize’ the universe?”

The drone emits a confused whir.∂

“Yeah, thought so,” Lumo says, snapping his fingers. The spell collapses, the dragon-drone powers down, and it drops harmlessly into a cloud below.

Lumo adjusts his robe, checks a holographic map, and sighs.
“Next time I’m saving the galaxy,” he mutters, “I’m charging extra.”
"""
]

var venzhwIsShow: [Int] = []
