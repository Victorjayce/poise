import 'package:sqflite/sqflite.dart';

// Auto-generated from the legacy BE_DB.db seed data.
// Difficulty mapping — Model: 10->easy, 20->mid, 30->hard
// Difficulty mapping — LevelUp: 20->easy, 30->mid, 50->hard, 100->extreme
// Type mapping: 0->daily, 1->weekly, 2->monthly
// Category mapping: 0->physical, 1->verbal, 2->social, 3->convo, 4->risk, 5->gender, 6->decision

final List<Map<String, Object?>> seedModelsData = [
  {
    'name': 'Heads up, Slow down',
    'description':
        'Walk with your head up (chin parallel) and maintain a steady, unhurried pace',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Look forward',
    'description':
        'Keep your gaze forward while passing people, avoid looking around or down',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Ambi-Dextro',
    'description':
        'Write 200 words and perform simple tasks using your non-dominant hand',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Stand still',
    'description':
        'Stand upright while waiting, no phone, no fidgeting, hands relaxed by your side',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Mirror hands-on practice',
    'description':
        'Stand in front of a mirror and talk while using hand gestures naturally',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'No distractions',
    'description':
        'Stand in a social environment without using your phone, remain present and composed',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Ad-Libing',
    'description':
        'Pick a random topic and speak about it out loud with no preparation',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Self-motivation',
    'description':
        'Look in the mirror and verbally affirm your goals, progress, and strengths',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Listen to your self-love',
    'description':
        'Record 3 things you like about yourself and listen without skipping',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Awkward Discomfort Combating',
    'description':
        'Watch something uncomfortable and sit through it without distraction',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Accustom yourself to disagreement',
    'description': 'Say no to a request without giving explanations',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Accustomed to hearing NO',
    'description':
        'Ask for something likely to be rejected and accept the response calmly',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'UnCringeable',
    'description':
        'Make an unfunny joke and don\'t explain or correct it if it fails',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Unawkwarded',
    'description':
        'Pause or stay silent when you run out of words, avoid filler sounds',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'No Maladaptivity',
    'description': 'Walk without zoning out or escaping into thoughts',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'No daydreaming',
    'description':
        'Watch something desirable without drifting into imagination, stop if it starts',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Self-conscious',
    'description':
        'Walk consciously and later recall your actions and surroundings',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'No regrets',
    'description':
        'Review past mistakes objectively and identify better responses',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Ad-Libing',
    'description':
        'Record yourself speaking on a random topic and listen back fully',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Cork exercises',
    'description':
        'Speak with a pen in your mouth to improve clarity and articulation',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Verbal Familiar',
    'description':
        'Record and listen to your voice to get used to your tone and pitch',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Physical/Verbal Familiar',
    'description': 'Speak in front of a mirror clearly and audibly',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Vocal unfazed',
    'description': 'Send a voice note without re-recording or editing it',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Vocal control',
    'description':
        'Consciously control your speaking speed and pitch in conversations',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Enunciation',
    'description': 'Speak slower than usual to improve clarity while talking',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Tongue twisters',
    'description': 'Practice and record tongue twisters clearly',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Verbal stability',
    'description': 'Pause before responding and avoid rushing your words',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Chill',
    'description': 'Wait 2–3 seconds before answering any question',
    'difficulty': 'easy',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Vocal Pitch',
    'description': 'Speak slightly louder than usual in conversations',
    'difficulty': 'easy',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Attention!',
    'description':
        'Sit in the front during a lecture and remain attentive throughout',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Join In',
    'description':
        'Approach a group, stay briefly, then contribute to their conversation',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Don\'t fear Attention',
    'description':
        'Walk in a slightly attention-drawing way (e.g. cap backwards) and observe reactions',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Public Work',
    'description':
        'Use your laptop in a busy public space and stay focused despite attention',
    'difficulty': 'mid',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Don\'t Run after class',
    'description':
        'Stay around for 20 minutes after class without rushing off or using your phone',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Refresh Friendships',
    'description': 'Greet multiple people you know within the same environment',
    'difficulty': 'mid',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Close Proximity',
    'description': 'Sit next to someone even when other spaces are available',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Ask for directions',
    'description': 'Ask a stranger for directions to a place',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Seatmate Interaction',
    'description':
        'Start a course-related conversation and learn their name before the end',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Present with others',
    'description': 'Sit or stand with others without using your phone',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'social',
  },
  {
    'name': 'Start with "How"',
    'description': 'Begin conversations using "how" questions',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Echoing',
    'description':
        'Repeat or paraphrase parts of what someone says during conversation',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Familiar Topic',
    'description': 'Start a conversation on a somewhat familiar topic',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Ask for advice',
    'description': 'Ask for advice on something you already understand',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Disagree',
    'description': 'Disagree with a statement calmly during a conversation',
    'difficulty': 'mid',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Use their name',
    'description':
        'Use the person\'s name multiple times during a conversation',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Open-ended convo',
    'description':
        'Start a conversation that requires more than yes/no responses',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Fact-check',
    'description': 'Correct or verify a statement during a conversation',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Unknown Topic',
    'description':
        'Get someone to talk about a topic you don\'t know for 3–5 minutes',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Unrelated comment',
    'description': 'Introduce a slightly unrelated comment into a conversation',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Pass without engagement',
    'description': 'Walk past someone you know without initiating interaction',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Walk through group',
    'description':
        'Walk through or past a group while maintaining posture and eye direction (horizon gaze)',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Eye contact',
    'description': 'Maintain eye contact with people as you walk past them',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Forward gaze',
    'description':
        'Keep your gaze forward consistently while walking past others',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Non-dominant usage',
    'description': 'Use your non-dominant hand for multiple daily actions',
    'difficulty': 'mid',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Horizon gaze',
    'description': 'Walk while keeping your gaze steady at horizon level',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Express with hands',
    'description': 'Use hand gestures while speaking to someone',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'physical',
  },
  {
    'name': 'Explain & Extend',
    'description':
        'Explain a concept for 60 seconds even if it takes 30 seconds normally',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Low pitch',
    'description': 'Speak at a lower pitch without whispering',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Audible whisper',
    'description': 'Speak softly but remain audible from a short distance',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'No fillers',
    'description': 'Speak for 3 minutes without using filler words',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Unplanned VN',
    'description': 'Send a voice note without planning or re-recording',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Public volume',
    'description': 'Slightly increase your voice in public conversations',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Delayed response',
    'description': 'Pause 3–5 seconds before answering questions',
    'difficulty': 'mid',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'verbal',
  },
  {
    'name': 'Desensitize embarrassment',
    'description':
        'Record and replay an embarrassing story until it feels neutral',
    'difficulty': 'mid',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Admit nervousness',
    'description': 'Tell someone you feel nervous in the moment',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Embrace silence',
    'description': 'Allow silence during conversations without filling it',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Public correction',
    'description': 'Walk the wrong way briefly, then turn around in public',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Stillness in crowd',
    'description': 'Stand still in a busy area and count to 30',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Repeat "what"',
    'description': 'Say "what?" multiple times without rushing to adjust',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Delay replies',
    'description': 'Read a message and intentionally delay your response',
    'difficulty': 'mid',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Boring story',
    'description':
        'Tell a deliberately uninteresting story without adjusting it',
    'difficulty': 'mid',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Public whisper VN',
    'description': 'Record a voice note quietly in a public space',
    'difficulty': 'mid',
    'type': 'daily',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Interrupt for opinion',
    'description':
        'Approach someone busy and ask for their opinion on something',
    'difficulty': 'hard',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Join active group',
    'description':
        'Join an ongoing group conversation and contribute without waiting for an invite',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Event introductions',
    'description':
        'Attend a public event and introduce yourself to multiple people',
    'difficulty': 'hard',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Personal story',
    'description': 'Tell a 2-minute personal story clearly and without rushing',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Group joke',
    'description':
        'Make a joke in a group without adjusting based on reactions',
    'difficulty': 'hard',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Advice & debate',
    'description':
        'Ask a stranger for advice, then challenge or question their response',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Call reconnect',
    'description':
        'Call someone you haven\'t spoken to recently and keep the conversation for 10 minutes',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Public question',
    'description': 'Ask a question audibly in a class or public setting',
    'difficulty': 'hard',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'End conversation',
    'description':
        'End a conversation intentionally and politely without waiting for it to fade',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'convo',
  },
  {
    'name': 'Greet with eye contact',
    'description': 'Make eye contact and greet a girl confidently',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'gender',
  },
  {
    'name': 'Ask opinion',
    'description': 'Ask a girl for her opinion on something directly',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'gender',
  },
  {
    'name': 'Join mixed group',
    'description':
        'Join a group conversation that includes girls and contribute',
    'difficulty': 'hard',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'gender',
  },
  {
    'name': 'Direct opinion',
    'description':
        'Share your opinion with a girl beside you without hesitation',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'gender',
  },
  {
    'name': 'Practice delivery',
    'description':
        'Record yourself simulating a conversation with a girl (eye contact, tone, composure)',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'gender',
  },
  {
    'name': 'Sustained eye contact',
    'description': 'Maintain eye contact while passing a girl or group',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'gender',
  },
  {
    'name': 'Share embarrassment',
    'description': 'Tell someone about an embarrassing experience openly',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Public VN',
    'description': 'Record a voice note in public with clear audibility',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Compliment and move',
    'description':
        'Give compliments to strangers without waiting for their response',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Rejection reps',
    'description': 'Get at least 3 people to say no to you in a day',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Leave mistakes',
    'description': 'Make a mistake in a group chat and leave it uncorrected',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Group chat presence',
    'description':
        'Start or join a group chat conversation and make humor without adjusting',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Express dissatisfaction',
    'description':
        'State dissatisfaction about something publicly without softening it',
    'difficulty': 'hard',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Share imperfect work',
    'description':
        'Show unfinished or "stupid" work to someone without disclaimers',
    'difficulty': 'hard',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'risk',
  },
  {
    'name': 'Immediate questioning',
    'description': 'Ask questions immediately when they come to mind',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'decision',
  },
  {
    'name': 'Voice intrusive thought',
    'description': 'Say a spontaneous thought without over-filtering it',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'decision',
  },
  {
    'name': 'Fast replies',
    'description': 'Reply to messages without overthinking your response',
    'difficulty': 'hard',
    'type': 'weekly',
    'is_enabled': 1,
    'category': 'decision',
  },
  {
    'name': 'Unfiltered opinion',
    'description': 'State your opinion in a group regardless of validation',
    'difficulty': 'hard',
    'type': 'monthly',
    'is_enabled': 1,
    'category': 'decision',
  },
];

final List<Map<String, Object?>> seedLevelUpsData = [
  {
    'level': 5,
    'is_active': 0,
    'difficulty': 'easy',
    'name': 'Order in a Busy Store',
    'category': 'physical',
    'description':
        'Go to a store with full customers and order confidently without lowering your voice, using your phone, or fidgeting afterward.',
  },
  {
    'level': 10,
    'is_active': 0,
    'difficulty': 'easy',
    'name': 'Neutral Stranger Conversation',
    'category': 'convo',
    'description':
        'Have a conversation with a stranger without trying to make your tone friendly in any way while maintaining composure and avoiding over-politeness.',
  },
  {
    'level': 20,
    'is_active': 0,
    'difficulty': 'mid',
    'name': 'Sit Near a Group Uninvited',
    'category': 'social',
    'description':
        'Go into a busy place, walk up to a group, sit around them without explaining yourself, and do not use your phone.',
  },
  {
    'level': 30,
    'is_active': 0,
    'difficulty': 'hard',
    'name': 'Interrupt a Group Conversation',
    'category': 'social',
    'description':
        'Walk into an ongoing group conversation and ask a completely unrelated question to interrupt briefly and get your answer without being overly rude or overly polite.',
  },
  {
    'level': 40,
    'is_active': 0,
    'difficulty': 'hard',
    'name': 'Make a Discomforting Public Request',
    'category': 'risk',
    'description':
        'Make a very discomforting request to someone in public clearly, audibly, and while remaining completely unbothered.',
  },
  {
    'level': 50,
    'is_active': 0,
    'difficulty': 'hard',
    'name': 'Collect Five Rejections',
    'category': 'risk',
    'description':
        'Make five absurd requests within less than two hours in the same environment with the goal of receiving “no” replies while remaining emotionally composed.',
  },
  {
    'level': 60,
    'is_active': 0,
    'difficulty': 'extreme',
    'name': 'Ask a Stupid Lecture Question',
    'category': 'decision',
    'description':
        'During a lecture, ask a very stupid but somewhat correlating question and handle the consequences stoically.',
  },
  {
    'level': 70,
    'is_active': 0,
    'difficulty': 'extreme',
    'name': 'Address an Entire Quiet Room',
    'category': 'social',
    'description':
        'Walk into an unbusy environment like a classroom and ask a question or make a request out loud to everyone present.',
  },
  {
    'level': 80,
    'is_active': 0,
    'difficulty': 'extreme',
    'name': 'Deliver a Prepared Public Speech',
    'category': 'social',
    'description': 'Prepare and deliver a public speech in front of people.',
  },
  {
    'level': 90,
    'is_active': 0,
    'difficulty': 'extreme',
    'name': 'Deliver an Unprepared Public Speech',
    'category': 'social',
    'description':
        'Deliver a public speech without proper preparation and avoid using filler words even when you run out of ideas.',
  },
  {
    'level': 100,
    'is_active': 0,
    'difficulty': 'extreme',
    'name': 'Perform an Unhinged Public Action',
    'category': 'decision',
    'description':
        'Do something absolutely unhinged in public that your past self would never have imagined doing.',
  },
];

Future<void> seedModels(Database db) async {
  final batch = db.batch();
  for (final m in seedModelsData) {
    batch.insert('models', m);
  }
  await batch.commit(noResult: true);
}

Future<void> seedLevelUps(Database db) async {
  final batch = db.batch();
  for (final l in seedLevelUpsData) {
    batch.insert('level_up', l);
  }
  await batch.commit(noResult: true);
}
