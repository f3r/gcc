class Migratestaticpages < ActiveRecord::Migration
  def up
    Cmspage.delete_all

    Cmspage.create(page_title: "How it works?", page_url: "how-it-works", mandatory: true, description: '<div id="how" class="info">
<div class="row">
<div class="intro span12">
<h2>How SquareStays works</h2>
<br />
<p>SquareStays offers a unique blend of exactly what you need in flexible professional accommodations - quality and trust at a reasonable price.</p>
<p>All SquareStays listings are designed to provide the comfort you expect from having a place of your own with the flexibility of a shorter-term stay.</p>
<p>SquareStays only lets professional landlords, owners, agents and property managers list places. This ensures you a high level of trust, service and quality for your stay.</p>
</div>
</div>
<div class="row columns">
<div class="span6">
<h3>Travelers</h3>
<img class="metaphor" src="http://s3.amazonaws.com/squarestays-static/travelers.jpg" alt="" />
<p>Simply use the place search and filter page on SquareStays to find a place that&rsquo;s right for you. You can narrow your search criteria by type of accommodation, price, and location.</p>
<p>Once you have found place that looks good for you, you can either make a reservation or make an inquiry. An inquiry is like a reservation, including the dates that you are looking for, as well as helping you understand the costs, but allows you to ask any further questions you might want to ask before making a reservation. A reservation, is, naturally, a reserved set of dates that you will stay at the place.</p>
<p>The place owner or listing member will typically answer your request within 24-48 hours. The owner may have some follow-up questions for you, so please remember to check in on the site regularly when you have inquiries pending.</p>
<p>Of course, you can always send general messages or questions to any other member on the site using the &ldquo;Send Message&rdquo; link on the member&rsquo;s profile page or when viewing the details of any place. If you ever have any problems or questions in communicating with other members, please contact us at <a href="mailto:support@squarestays.com">support@squarestays.com</a></p>
</div>
<div class="span6">
<h3>Listing members</h3>
<img class="metaphor" src="http://s3.amazonaws.com/squarestays-static/listing_members.jpg" alt="" />
<p>If you would like to list a property on SquareStays, please contact us at <a href="mailto:places@squarestays.com">places@squarestays.com</a>. The SquareStays team will then work with you to ensure that you understand the requirements for listings on SquareStays.</p>
<p>In general, all properties on SquareStays should be fully-furnished, full units with all utilities turned on. We encourage you to provide as much information as possible about the short-term availability terms, for instance, if your units have a minimum stay of one month, two months or more. Also, please be clear with any other conditions you may have, such as security deposit or clean-up fees. Finally, providing as many high-quality photos as possible is extremely valuable for potential tenants.</p>
<p>Once you have emailed us, we will enable your account to create listings, usually within 2 business days. Please watch your email for any incoming messages and inquiries from interested tenants, and email us at any time at <a href="mailto:support@squarestays.com">support@squarestays.com</a> with any questions you may have.</p>
</div>
</div>
<div class="row actions">
<div class="span6"><form class="button_to" action="/places/singapore" method="get">
<div><input class="btn btn-large btn-info" type="submit" value="Find a place" /></div>
</form></div>
<div class="span6"><form class="button_to" action="/signup" method="get">
<div><input class="btn btn-large btn-info" type="submit" value="List your properties" /></div>
</form></div>
</div>
<div class="row">
<div class="well">
<h3>Payments</h3>
<br />
<p>SquareStays listings are designed to have full disclosure and no hidden fees! When you make an inquiry or a reservation, you should know exactly how much it will cost. All SquareStays fees are built into the prices shown on the site.</p>
<p>SquareStays offers payments by credit card, PayPal and bank transfer. Please contact us at <a href="mailto:support@squarestays.com">support@squarestays.com</a> with any questions.</p>
</div>
</div>
</div>', active: 1 )


Cmspage.create(page_title: "Why SquareStays?", page_url: "why", mandatory: true, description: '<div id="why" class="info">
<div class="intro span12">
<h3>Why SquareStays?</h3>
<p>SquareStays connects you with trusted, professional, short-term accommodations.</p>
<p>What does this mean?</p>
<p>SquareStays works with property owners, landlords and innovative real estate professionals to get high-quality listings. Places listed on SquareStays differ from other sites in a few key ways:</p>
<ul>
<li>SquareStays places are designed for professionals. Our agents and owners know that business travellers demand a higher level of quality and a minimum set of conveniences.</li>
<li>Our listings are designed to be very thorough. We want to make sure you get all the information you need to make a decision without wasting your time viewing and inquiring on places that aren&rsquo;t right for you.</li>
<li>All places are available for short-term, some as short as one week, most from one month to six months.</li>
<li>All places should tell you up-front what amenities, furniture and facilities are available for your use.</li>
<li>You should get a very clear and precise listing of all the costs involved, from deposits to rent to utilities for places on SquareStays. There are no hidden fees or extras.</li>
</ul>
<div class="get-started"><a class="btn btn-primary btn-large btn-info" style="width: 210px;" href="/why?trigger_signup=true">Get Started!</a></div>
</div>
<div class="span16">
<div class="well">
<h4>Trust</h4>
<p>SquareStays members typically link their SquareStays accounts to Facebook, Twitter or LinkedIn. This lets you see who is really behind the place you see online. You can communicate with them openly through our messaging system and ask any questions.</p>
<p>Additionally, people listing places can ask questions to make sure you are the right person for them. We have heard consistently from both property listing members and tenant members, that the process for finding short-term accommodations is very challenging, and communication becomes problematic. SquareStays helps solve this problem by providing a centralized communication system where either side can quickly see the other&rsquo;s profile and listings.</p>
</div>
<div class="well">
<h4>Flexibility</h4>
<p>SquareStays knows that business professionals in the modern economy have jobs that may take them all over the world, often for short-term assignments. SquareStays makes sure that all property listing members understand this and can accommodate.</p>
</div>
<div class="well">
<h4>Affordability</h4>
<p>SquareStays provides high-quality offerings, ranging from a single room to a full luxury condominium. We view affordability as a comparative measure - are SquareStays listings more affordable than comparable accommodations from elsewhere? For instance, our full apartment and condominium listings are benchmarked against the price of serviced apartments or corporate housing.</p>
</div>
<div class="well">
<h4>Where is SquareStays?</h4>
<p>SquareStays focuses on the Asia-Pacific region, including eastern Asia and Australia / New Zealand. With business travel to Asia-Pacific increasing and hotel prices sky-rocketing, finding a place to stay for business travel has become increasingly difficult.</p>
</div>
<div class="well singapore-first">
<h4>Singapore - the first city on Squarestays</h4>
<p>As a hub that connects the east and the west, Singapore is an important market in the Asian business economy with sustained growth and top-rated business environment. SquareStays is now available in Singapore and plans to expand in other major cities soon.</p>
<img src="http://s3.amazonaws.com/squarestays-static/singapore.jpg" alt="" /></div>
</div>
</div>', active: 1 )

Cmspage.create(page_title: "Welcome to Singapore", page_url: "singapore-city-guide", description: '<div class="span16">
<div class="row">
<h2>Welcome to Singapore!</h2>
</div>
<br />
<div class="row">
<p>Singapore is the first city available on SquareStays. It&rsquo;s natural, because Singapore is also home for us! Singapore is a rising business power across Asia. For westerners, Singapore can help in bridging the gap between east and west and providing gateways to Asia, particularly to China and India. And for Asian companies and cultures, Singapore is a bridge to the west.</p>
<p>Singapore is a city state of around 5 million people on an area of approximately 700 square kilometers (~274 square miles). Most of the population lives on the main island of Singapore, although there are small neighborhoods on the islands of Sentosa and Pulau Ubin as well.</p>
<p>Singapore was originally a Malay settlement, then a British crown colony, before becoming independent in 1965. Since independence, Singapore has achieve remarkable stability and unity amongst its very diverse population base.</p>
<p>The main economic drivers are shipping, tourism, financial services, oil and gas (refining and trading) and other export-oriented sectors. About 10 million visitors come to Singapore each year.</p>
<h3>Business in Singapore</h3>
<p>Singapore is known for its transparent, stable business environment. Singapore often rates as the easiest place to do business, and has virtually no corruption!</p>
<h3>Accommodation in Singapore</h3>
<p>While Singapore has a large selection of hotels, prices tend to be high. Average business hotels regularly cost more than $120 USD / night. Extended stays for short-term corporate assignments have traditionally gravitated towards serviced apartments at exorbitant rates. This is where SquareStays comes in - providing an affordable alternative with luxury, and comfort at substantial savings!</p>
<br /><center><a class="btn btn-primary btn-large center-block" type="submit" href="/singapore">Find a Place in Singapore!</a></center>
<h3>Helpful links</h3>
<ul>
<li>Singapore on <a href="http://en.wikipedia.org/wiki/Singapore">Wikipedia</a></li>
<li>A Singapore <a href="http://www.singaporeexpats.com">expat forum</a> and another <a href="http://www.expatsingapore.com">expat forum</a> for Singapore</li>
<li>The leading Singapore <a href="http://www.propertyguru.com.sg">real estate portal</a> for long-term rentals and purchases</li>
<li><a href="http://www.singaporehotels.com">Singapore hotels</a> (for stays under one month)</li>
</ul>
<h3>Sources</h3>
<ul>
<li><a href="http://en.wikipedia.org/wiki/Economy_of_Singapore">Economy of Singapore</a></li>
<li><a href="https://www.stbtrc.com.sg/images/links/X1Annual_Report_on_Tourism_Statistics_2009.pdf">Annual Report on Tourism Statistics (2009)</a></li>
<li><a href="http://www.straitstimes.com/BreakingNews/Singapore/Story/STIStory_725306.html">Strait Times</a></li>
<li><a href="http://cpi.transparency.org/cpi2011/results/#CountryResults">Transparency.org</a></li>
</ul>
</div>
</div>', active: 1 )

Cmspage.create(page_title: "Welcome to Hong Kong!", page_url: "hong-kong-city-guide", description: '<div class="span16">
<div class="row">
<h2>Welcome to Hong Kong!!</h2>
</div>
<br />
<div class="row">
<p>Hong Kong is the second city available on SquareStays. Hong Kong has been an Asian tiger economy for years, and is the main gateway to China for many multinational corporations.</p>
<p>Hong Kong is a special administrative region (SAR) of China, with a population of just over 7 million people crammed into a land area of approximately 1100 square kilometers (~426 square miles). About 40% of the land in Hong Kong is protected and unusable for residential development because of its hilly nature. That leads to a very high population density in residential areas, which in turn causes extreme prices in real estate.</p>
<p>Hong Kong has a long and rich history, and has been fought over and ruled by several world powers. Hong Kong was one of the last British colonies, and only reverted to Chinese possession and rule in 1997.</p>
<h3>Business in Hong Kong</h3>
<p>The main economic drivers are financial services and shipping. Hong Kong offers one-day company incorporation and a number of low- or no-tax schemes for new companies or offshore corporations.</p>
<h3>Accommodation in Hong Kong</h3>
<p>While Hong Kong has a large selection of hotels, prices are extremely high. Average business hotels regularly cost more than $200 USD / night. Serviced apartments are priced even higher, as they offer more space and a more complete suite of services. Serviced apartments in Hong Kong are normally full. SquareStays can help by offering fully furnished short-term rentals at reasonable prices and with good availability!</p>
<br /><center><a class="btn btn-primary btn-large" type="submit" href="/hong_kong">Find a Place in Hong Kong!</a></center>
<h3>Helpful links</h3>
<ul>
<li>Hong Kong on <a href="http://en.wikipedia.org/wiki/Hong_Kong">Wikipedia</a></li>
<li>A Hong Kong <a href="http://www.hkexpats.com/">expat forum</a>, another <a href="http://hongkong.geoexpat.com">expat forum</a> and one last <a href="http://hongkong.asiaxpat.com">expat forum</a> for Hong Kong</li>
<li>The leading real estate portals for long-term rentals and purchases in Hong Kong: <a href="http://www.squarefoot.com.hk">squarefoot</a> and <a href="http://www.chooze2move.com">chooze2move</a></li>
<li><a href="http://www.hongkonghotel.com">Hong Kong hotels</a> (for stays under one month)</li>
</ul>
<h3>Sources</h3>
<ul>
<li><a href="http://en.wikipedia.org/wiki/Economy_of_Hong_Kong">Economy of Hong Kong</a></li>
<li><a href="http://startupr.com/country-list/asia/hong-kong">Startupr article</a></li>
</ul>
</div>
</div>', active: 1 )


Cmspage.create(page_title: "Welcome to Kuala Lumpur", page_url: "kuala-lumpur-city-guide", description: '<div class="span16">
<div class="row">
<h2>Welcome to Kuala Lumpur!!</h2>
</div>
<br />
<div class="row">
<p>Kuala Lumpur is the capital city and the heart of Malaysia! Malaysia is a diverse country, with people of several different ethnic groups, religions and cultural backgrounds. Kuala Lumpur, with a population of over 6 million, is the largest city, sitting at the convergence of the Gombak and Klang rivers, in the Klang valley.</p>
<p>Areas of Malaysia were colonized by the British, the Dutch and the Portuguese, and were eventually unified under British control in the colony of Malaya. Since independence in 1963, Malaysia has developed rapidly, with strong population, economic and human development growth.</p>
<p>Malaysia has dynamic and diverse economy, leveraging production, natural resources and services. Malaysia has averaged a very strong 5%+ GDP consistently for several years.</p>
<h3>Business in Kuala Lumpur, Malaysia</h3>
<p>Some of Malaysia&rsquo;s key natural resources are oil, gas, tin, rubber, minerals, palm oil. Malaysia is one of the world&rsquo;s major exporters of semiconductors and computer memory and storage. Malaysia is also home to the world&rsquo;s largest Islamic banking and finance service sector. Kuala Lumpur is the undisputed center for all trading and related activity in Malaysia&rsquo;s economy, as well as being the banking hub.</p>
<h3>Accommodation in Kuala Lumpur</h3>
<p>Kuala Lumpur has a very large selection of hotels, with prices and quality varying from ultra-luxury to the most basic, and everything in between. Business hotels in the most desirable locations will normally be above $150 USD / night. Serviced apartments are very expensive and difficult to find in Kuala Lumpur. This is where SquareStays comes in - providing luxury, and comfort in Kuala Lumpur at substantial savings!</p>
<br /><center><a class="btn btn-primary btn-large" type="submit" href="/kuala_lumpur">Find a Place in Kuala Lumpur!</a></center>
<h3>Helpful links</h3>
<ul>
<li>Malaysia on <a href="http://en.wikipedia.org/wiki/Malaysia">Wikipedia</a></li>
<li>An <a href="http://www.expatkl.com/ver09/indexcontent.php">KL expat forum</a> and another <a href="http://klexpatmalaysia.com/">Kuala Lumpur expat portal</a></li>
<li>The leading Malayasia and Kuala Lumpur <a href="http://www.homeguru.com.my">real estate portal</a> for long-term rentals and purchases</li>
<li><a href="http://www.kualalumpurhotels.com/">Kuala Lumpur hotels</a> (for stays under one month)</li>
</ul>
<h3>Sources</h3>
<ul>
<li><a href="http://en.wikipedia.org/wiki/Economy_of_Malaysia">Economy of Malaysia</a></li>
<li><a href="http://corporate.tourism.gov.my/research.asp?page=facts_figures">Tourism Malaysia Statistics (up to 2010)</a></li>
</ul>
</div>
</div>', active: 1 )


Cmspage.create(page_title: "Terms", page_url: "terms", mandatory: true, description: '<div class="span16">
<h3>SquareStays Terms of Use / Member Agreement</h3>
<p>PLEASE READ THESE TERMS OF USE CAREFULLY AS THEY CONTAIN IMPORTANT INFORMATION REGARDING YOUR LEGAL RIGHTS, REMEDIES AND OBLIGATIONS. THESE INCLUDE VARIOUS LIMITATIONS AND EXCLUSIONS, AND A CLAUSE THAT GOVERNS THE JURISDICTION AND VENUE OF DISPUTES.</p>
<p>THE FOLLOWING DESCRIBES THE TERMS ON WHICH HEYPAL PRIVATE LIMITED OFFERS YOU ACCESS TO OUR SITE (SQUARESTAY.COM, SQUARESTAYS.COM) AND SERVICES.</p>
<p>Welcome to the Web sites and Web services operated by HeyPal Private Limited (hereafter referred to as "HeyPal," "we," "us," or "our"), a Singapore corporation. HeyPal maintains www.SquareStays.com (hereafter "Site"), as a service to our users, members and visitors (our Site and such services, collectively hereafter, our "Services"). By using this Site or Services, you agree to comply with and be legally bound by the following terms of use ("Terms"), whether or not you become a registered user or member (hereafter "Member") of the Services. Please review the following terms carefully. If you do not agree to these terms, you have no right to obtain information from or otherwise continue using this Site or Services. Failure to use this Site or Services in accordance with the following terms of use may subject you to severe civil and criminal penalties. We reserve the right to modify these Terms or policies relating to the Services at any time, effective upon posting of an updated version of these Terms on the Site. You are responsible for regularly reviewing these Terms. By using this Site or Services, you agree that the posting of new or revised terms and conditions on the Site or Services will constitute adequate and constructive notice to you of any and all revisions and changes. Continued use of the Services after any such changes or after explicitly accepting the new Terms upon logging into the site shall constitute your consent to such changes.</p>
<ol>
<li>USER RESPONSIBILITIES<ol>
<li>Neutral Venue. Our Site or Services are an online venue through which Members find and learn about each other. Our Site or Services are merely a venue for Members to learn about one another and, if they wish, arrange the time-limited rental of physical residence premesis (hereafter "Places") with one another. Members who buy, rent or receive Places from other Members shall be defined as Buyers (hereafter "Buyers"). Members who sell, rent or give Places to other Members shall be defined as Sellers (hereafter "Sellers"). We are not involved in any interactions between Members. As a result, we have no control over the conduct of our Members or the truth or accuracy of the information that Members post on the Site or Services.</li>
<li>Member Identity. We make no attempt to confirm, and do not confirm, any Member\'s purported identity. You are responsible for determining the identity and suitability of others who you may contact by means of this Site or Services. We do not endorse any persons who use or register for our Services, whether as Buyers or Sellers. We do not investigate any Member\'s reputation, conduct, morality, criminal background, or verify the information that any Member submits to the Site or Services. We encourage you to communicate directly with potential Sellers and Buyers through the tools available on the Site or Services and to review your Sellers&rsquo; and Buyers&rsquo; profile pages for feedback from other Members.</li>
<li>Your Experience with Other Members. You are solely responsible for your interactions with other Members of our Services. We will not be responsible for any damage or harm resulting from your interactions with other Members of our Services, including, without limitation, any economic damages, losses, bodily injury, emotional distress, and/or any other damages that may result from your interactions, communications, or meetings with other Members, whether online or offline. We will not be responsible for any damage or harm resulting from goods or services exchanged with other Members of our Services. We reserve the right, but have no obligation, to monitor interactions between you and other Members of our Services and to take any other action in good faith to restrict access to or the availability of any material that we or another Member of our Services may consider obscene, lewd, lascivious, filthy, violent, harassing or otherwise objectionable. You should make whatever investigation you feel necessary or appropriate and take reasonable precautions before proceeding with any online or offline (including meeting in person) transactions with any other Member.<ol>
<li>We recommend you use common sense and best practices for any offline or personal interactions with other Members. Third-party sites such as <a href="http://getsafeonline.org">http://getsafeonline.org</a> and <a href="http://wiredsafety.org">http://wiredsafety.org</a> may provide useful guidelines.</li>
<li>You are solely responsible for your interactions with other Members. You understand that SquareStays does not in any way screen its Members, nor does SquareStays inquire into the backgrounds of its Members or attempt to verify the statements of its Members. SquareStays makes no representation or warranty as to the conduct of its Members or their suitability for transactions with any or all other Members. You agree to take reasonable precautions and full personal responsibility in/for all interactions with other Members of SquareStays, particularly if you decide to meet offline or in person. You understand that SquareStays makes no guarantees, either express or implied, regarding any Places or transactions on SquareStays. You should not provide your financial information (for example, your credit card or bank account information) to other Members.</li>
</ol></li>
<li>Release. You agree that SquareStays shall not be responsible or liable for any loss or damage of any sort incurred as the result of any interactions between you and other Members. If there is a dispute between participants or Members of this Site, you understand and agree that SquareStays is under no obligation to become involved. In the event that you have a dispute with one or more other participants or Members of the Site, you hereby release SquareStays, its officers, directors, employees, agents, successors, assigns and affiliates, from claims, demands and damages (actual, consequential, nominal, punitive, or otherwise) of every kind or nature, known or unknown, suspected and unsuspected, disclosed and undisclosed, past, present or future, arising out of or in any way related to Content on the Site, communications or interactions with other Members on the Site or your experience as a Buyer of Seller in connection with the Site or Services. You agree that your sole and exclusive remedy for any losses or damages relating to the use of our Services shall be against those other Members whose acts or omissions you allege to have caused you harm.</li>
</ol></li>
<li>USER CONDUCT<ol>
<li>Site Rules and Restrictions. In connection with your use of our Services, you must act responsibly and exercise good judgment. Without limiting the foregoing, you will not:<ol style="list-style-type: lower-alpha;">
<li>violate any local, state, provincial, national, or other law or regulation, or any order of a court;</li>
<li>infringe on the rights of any person or entity, including without limitation, their intellectual property, privacy, publicity or contractual rights, including but not limited to any transactions related to any Places, without the rights to do so;</li>
<li>interfere with or damage our Services, including, without limitation, through the use of viruses, bots, Trojan horses, harmful code, flood pings, denial-of-service attacks, packet or IP spoofing, forged routing or electronic mail address information or similar methods or technology;</li>
<li>use our Services to transmit, distribute, post or submit any information concerning any other person or entity, including without limitation, photographs of others without their permission, personal contact information or credit, debit, calling card or account numbers;</li>
<li>contact anyone who has asked not be contacted;</li>
<li>collect personal data about other users for commercial or unlawful purposes;</li>
<li>use automated means, including spiders, robots, crawlers, data mining tools, or the like to download data from the Site or Service unless expressly permitted by SquareStays;</li>
<li>use our Services in connection with the distribution of unsolicited commercial email ("spam") or advertisements unrelated to SquareStays and SquareStays Services;</li>
<li>"stalk" or harass any other Member of our Services or collect or store any information about any other Member other than for purposes of transacting as a SquareStays Member;</li>
<li>offer Places that you do not own;</li>
<li>register for more than one Member account or register for a Member account on behalf of an individual other than yourself;</li>
<li>impersonate any person or entity, or falsify or otherwise misrepresent yourself or your affiliation with any person or entity;</li>
<li>use automated scripts to collect information or otherwise interact with the Services or the Site;</li>
<li>use the Site to find goods and then complete the transaction offline in order to circumvent your obligation to pay for the Services;</li>
<li>submit any listing with a false or misleading price, stolen Place(s), non-existent Place(s), fake Place(s), counterfeit Place(s), or submit any listing with a price that you do not intend to honor;</li>
<li>advocate, encourage, or assist any third party in doing any of the foregoing; or</li>
<li>interfere with or disrupt the Services or the Site or the servers or networks connected to the Services or the Site.</li>
</ol>The foregoing is merely a list of examples of prohibited conduct. SquareStays reserves the right to cancel a Member account or take other appropriate actions in its sole discretion in response to any inappropriate conduct, or for no reason at all.</li>
<li>Disputes with Other Members. You are solely responsible for your interactions with other SquareStays Members. You are solely responsible for resolving any and all disputes with other SquareStays Members.</li>
<li>Listing Prices. If you post a listing offering a good through the Site, which is accepted by you, and another Member, you acknowledge and agree that the price you specify for that listing will constitute an essential part of a binding agreement between you and the Member. You further agree not to alter the price once accepted.</li>
</ol></li>
<li>MINORS MAY NOT USE SERVICES. You must be at least 18 years old to register to use the Services. By registering to use our Services, you represent that you are over 18.</li>
<li>PRIVACY. The Privacy Policy of SquareStays is available on the Site at <a href="/privacy">http://www.SquareStays.com/privacy</a> and is hereby incorporated by reference. You agree to abide by all terms set forth in the Privacy Policy.</li>
<li>YOUR CONTENT<ol>
<li>Content. You understand that all postings, messages, text, files, images, photos, video, sounds, or other materials ("Content") posted on, transmitted through, or linked from the Site or Service, are the sole responsibility of the person from whom such Content originated. More specifically, you are entirely responsible for each individual Place of Content that you post, email or otherwise make available via the Site or Service. You understand that SquareStays does not control, and is not responsible for Content made available through the Service, and that by using the Service, you may be exposed to Content that is offensive, indecent, inaccurate, misleading, or otherwise objectionable. Furthermore, the Site and Content available through the Service may contain links to other websites, which are completely independent of SquareStays. SquareStays makes no representation or warranty as to the accuracy, completeness or authenticity of the information contained in any such site. Your linking to any other websites is at your own risk. You agree that you must evaluate, and bear all risks associated with, the use of any Content, that you may not rely on said Content, and that under no circumstances will SquareStays be liable in any way for any Content or for any loss or damage of any kind incurred as a result of the use of any Content posted, emailed or otherwise made available via the Site or Service. You acknowledge that SquareStays does not pre-screen or approve Content, but that SquareStays shall have the right (but not the obligation) in its sole discretion to refuse, delete or move any Content that is available via the Site or Service, for violating the letter or spirit of the Terms or for any other reason.</li>
<li>You Grant Us a License. By submitting any Content to our Site or Services, you hereby grant us a perpetual, worldwide, non-exclusive, royalty-free license to use, reproduce, display, perform, adapt, modify, sell, distribute, have distributed and promote such Content in any form, in all media now known or hereinafter created and for any purpose, subject to the Privacy Policy as described in Section 4. You represent and warrant that you have sufficient rights to grant us this license.</li>
<li>Content Restrictions. You are solely responsible for any Content that you submit, post or transmit via our Services. You may not post, submit, or otherwise make available any Content that:<ol style="list-style-type: lower-alpha;">
<li>is unlawful, harmful, threatening, abusive, harassing defamatory, libelous, invasive of another&rsquo;s privacy, or is harmful to minors in any way;</li>
<li>infringes any patent, copyright, trademark, trade secret or other intellectual property rights or proprietary rights of any person, or Content that you do not have a right to make available under any law or under contractual or fiduciary relationships;</li>
<li>impersonates any person or entity or falsely states or otherwise misrepresents your affiliation with a person or entity except for Content that constitutes lawful non-deceptive parody of public figures;</li>
<li>includes personal or identifying information about another person without that person&rsquo;s explicit consent;</li>
<li>is false, deceptive, misleading, deceitful, misinformative, or constitutes &ldquo;bait and switch&rdquo;;</li>
<li>contains nudity or sexually explicit content, or is otherwise obscene or pornographic;</li>
<li>harasses, degrades, intimidates or disparages any individual or groups of individuals on the basis of religion, gender, sexual orientation, race, ethnicity, age, disability, or other stereotypical depiction;</li>
<li>depicts individuals under 18 years of age;</li>
<li>depicts or advocates the use of illicit drugs;</li>
<li>makes use of offensive language or images;</li>
<li>characterizes violence as acceptable, glamorous or desirable;</li>
<li>promotes or contains information related to gambling;</li>
<li>constitutes or contains "affiliate marketing," "link referral code," "junk mail," "spam," "chain letters," "pyramid schemes," or unsolicited commercial advertisement;</li>
<li>includes links to commercial services or web sites, except as may be allowed by SquareStays;</li>
<li>contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment;</li>
<li>disrupts the normal flow of dialogue with an excessive amount of Content (flooding attack) to the Site or Services, or that otherwise negatively affects other Members\' ability to use the Services; or</li>
<li>contains stolen, fake, counterfeit or non-existent Place(s); or</li>
<li>employs misleading email addresses, or forged headers or otherwise manipulated identifiers in order to disguise the origin of Content transmitted through the Services.</li>
</ol></li>
<li>No Obligation to Post Content. We have no obligation to post any Content from you or anyone else. In addition, we may, in our sole and unfettered discretion, edit, remove or delete any Content that you post or submit.</li>
</ol></li>
<li>THIRD-PARTY CONTENT. In using our Services, you may be exposed to content and information from other Members or third parties ("Third-Party Content"), either at our Site or Services or through links to third-party websites. We do not control, and shall have no responsibility for, Third-Party Content, including material that may be unlawful, misleading, incomplete, erroneous, offensive, indecent or otherwise objectionable. You must evaluate the veracity of, and bear all risks associated with your exposure to, Third-Party Content, including without limitation, profiles of other Members of our Services.</li>
<li>PAYMENT<ol><ol>
<li>Fee Structure. In exchange for providing the Services, SquareStays keeps a small portion of the payment Buyer makes in each transaction or use of Place (the &ldquo;Transaction Fee&rdquo;). As a buying or renting Member (Buyer), you agree to pay the amount posted by the selling or leasing Member (Seller) with whom you have chosen to transact. As a Seller, posting your listing is free, but you agree to pay SquareStays the Transaction Fee for each transaction. Some optional services or functionality may incur additional service fees. The Transaction Fees will be listed at</li>
</ol></ol><a href="/fees">http://www.squarestays.com/fees</a><ol>
<li>Payment Logistics. If you find a listing that you are interested in completing a transaction on SquareStays, you will be asked to provide your credit card information and billing address. We will obtain a pre-authorization for the total amount of the transaction to ensure that you have the necessary amount of funds available to cover the transaction, but will not charge your card at that time. Alternatively we may charge you U.S. One Dollar (USD $1) to verify that the card works. If the Seller who posted the listing accepts your offer, your card will be charged the full balance at the time of acceptance; if the posting Member fails to respond or opts not to accept your offer, any charges will be refunded and the pre-authorization will be released. The funds will be held by SquareStays until use of the Place(s) is confirmed; shortly thereafter, SquareStays will remit the held funds to the Seller, less SquareStays&rsquo;s Transaction Fee and any other applicable service fees. Buyer is requested to confirm completion of use of Place) within 48 hours of completion of use. In the event Buyer fails to confirm completion, SquareStays will remit funds to the Seller upon Seller providing proof of completion to SquareStays.</li>
<li>Cancellation and Refunds. If you cancel your transaction before the Seller accepts and confirms the transaction, SquareStays will return the funds to you in accordance with the cancellation policy.</li>
<li>Donations. Some Sellers may pledge to donate a portion of the funds they receive to a particular cause or charity. We do not control, and will not take any responsibility or liability for, whether or not the Seller has in fact made the donation as pledged.</li>
<li>Privacy. Our privacy policy governs the handling, storage, and use of any information you submit to us, including credit card billing information. Please see Section 4 of these Terms for further information on this policy.</li>
<li>Taxes. SquareStays does not do business as an owner or seller of physical places, locations, or goods. SquareStays does not own, sell, resell, furnish, provide, rent, re-rent, manage and/or control physical places, locations or goods. SquareStays does not act as an agent for any providers, sellers, buyers, lenders or givers of physical places, locations or goods. SquareStays merely makes available a marketplace for Sellers and Buyers to meet and arrange for transactions. SquareStays is not a contracting agent or representative of the Seller or Buyer. Instead, SquareStays&rsquo;s role is solely to facilitate the availability of this marketplace for the Seller and Buyer and to provide services related thereto, and any agreement for the use of any places, locations or goods is solely between the Seller and Buyer, and not SquareStays. You understand that we are acting solely as an intermediary for the collection of fees between you and any Sellers or Buyers with whom you choose to enter into a transaction. We cannot and do not offer tax advice to either Sellers or Buyers. It is your responsibility to determine whether any tax is due with respect to a transaction and, if so, to remit such tax to the appropriate taxing authority.</li>
<li>Damages. As a Buyer, you are responsible for maintaining any borrowed or rented places, locations or goods in the condition that it was given to you. In the event that a Seller claims otherwise and provides evidence of damage, including but not limited to photographs, you agree to pay the cost of replacing the damaged Places with equivalent Places.</li>
</ol></li>
<li>PROPRIETARY RIGHTS<ol>
<li>Our Intellectual Property. Material on our Site or Services (with the exception of Third-Party Content) is protected by rights of publicity, copyright, trademark, trade secret, and other proprietary rights and intellectual property laws as applicable. Except as expressly authorized by us, you may not sell, license, rent, modify, distribute, copy, reproduce, transmit, publicly display, publicly perform, publish, adapt, edit or create derivative works from such material. "Hey Pal," "HeyPal," &ldquo;SquareStays&rdquo;, &ldquo;SquareStay&rdquo;, &ldquo;Can you spare a planet?,&rdquo; &ldquo;www.SquareStay.com&rdquo;, &ldquo;www.SquareStays.com&rdquo; and "www.HeyPal.com" are trademarks of HeyPal protected by international law; you agree not to use such marks for any purpose, including but not limited to as metatags on other websites, in written materials or otherwise.</li>
<li>Your Use of Our Intellectual Property. You may not systematically retrieve data or other Content from our Site or Services to create or compile, directly or indirectly, in single or multiple downloads, a collection, compilation, database, directory or the like, whether by manual methods, through the use of bots, crawlers, or spiders, or otherwise without prior written consent from SquareStays. You may not display any portion of our Site or Services in a frame (or any content from our Site or Services through in-line links) without our prior written consent, which may be requested by contacting us at help@SquareStays.com. You may, however, establish ordinary links to the homepage of our Site or Services without our written permission, and you may make use of embedded HTML if we have provided the HTML code. You may not decompile or disassemble, reverse engineer or otherwise attempt to discover any source code contained in the Services. Without limiting the foregoing, you agree not to reproduce, duplicate, copy, sell, resell or exploit for any commercial purposes, any aspect of the Content or Services.</li>
</ol></li>
<li>USERNAME AND PASSWORD. You will select a username and password as part of the registration process. You are solely responsible for the confidentiality and use of your username and password. You must: (a) log off from your account at the end of each session on our Site or Services; and (b) notify us immediately of any unauthorized use of your username and password or any other breach of security.</li>
<li>TERMINATION. We may, in our discretion and without liability to you, with or without cause, with or without prior notice and at any time: (a) terminate your access to our Services, (b) deactivate or delete any of your accounts and all related information and files in such accounts, (c) bar your access to any of such files or Services, and (d) terminate any and all Services offered by SquareStays. Upon termination we will promptly pay any Seller fees held in escrow and due to Seller, less our Transaction Fee and any applicable service fees.</li>
<li>MODIFICATION OF SERVICES. We may, in our discretion and without liability to you, with or without prior notice and at any time, modify or discontinue, temporarily or permanently, any portion of our Services.</li>
<li>LEGAL COMPLIANCE. You shall use our Services in a manner consistent with any and all applicable local, state, national and international laws and regulations.</li>
<li>DISCLAIMER OF WARRANTIES<ol>
<li>IF YOU USE OUR SERVICES, YOU DO SO AT YOUR SOLE RISK. YOU ACKNOWLEDGE AND AGREE THAT SquareStays DOES NOT CHECK ANY BUYER, SELLER, OR OTHER MEMBER\'S BACKGROUND OR RECORD. SquareStays IS A REPUTATION-BASED SYSTEM. TAKE ADVANTAGE OF OTHER MEMBERS\' COMMENTS AND THIRD-PARTY REFERRALS ON SELLERS AND BUYERS. USE COMMON SENSE. BE AWARE AND BE SAFE. OUR SERVICES ARE PROVIDED ON AN "AS IS" AND "AS AVAILABLE" BASIS, WITHOUT ANY WARRANTIES OF ANY KIND. WE EXPRESSLY DISCLAIM, AND YOU WAIVE, ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT OF PROPRIETARY RIGHTS.</li>
<li>WE DO NOT WARRANT THAT (A) OUR SERVICES WILL MEET YOUR REQUIREMENTS; (B) OUR SERVICES WILL BE UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE; (C) ANY INFORMATION THAT YOU MAY OBTAIN THROUGH OUR SERVICES WILL BE ACCURATE OR RELIABLE; (D) THE QUALITY OF ANY PRODUCTS, SERVICES, INFORMATION OR OTHER MATERIAL PURCHASED OR OBTAINED BY YOU THROUGH OUR SERVICES WILL MEET YOUR EXPECTATIONS; OR (E) ANY ERRORS IN ANY DATA OR SOFTWARE WILL BE CORRECTED.</li>
<li>IF YOU ACCESS OR TRANSMIT ANY CONTENT THROUGH THE USE OF OUR SERVICES, YOU DO SO AT YOUR OWN DISCRETION AND YOUR SOLE RISK. YOU ARE SOLELY RESPONSIBLE FOR ANY LOSS OR DAMAGE ARISING OUT OF SUCH ACCESS OR TRANSMISSION.</li>
<li>UNDER NO CIRCUMSTANCES WILL SquareStays OR ANY OF ITS OFFICERS, EMPLOYEES, AGENTS AND SUCCESSORS IN RIGHTS BE RESPONSIBLE FOR ANY LOSS OR DAMAGE, INCLUDING PERSONAL INJURY OR DEATH, RESULTING FROM ANYONE\'S USE OF THE SITE OR THE SERVICES, ANY CONTENT POSTED ON THE SITE OR TRANSMITTED TO MEMBERS, OR ANY INTERACTIONS BETWEEN USERS OF THE SITE, WHETHER ONLINE OR OFFLINE.</li>
<li>NO DATA, INFORMATION OR ADVICE OBTAINED BY YOU IN ORAL OR WRITTEN FORM FROM US OR THROUGH OR FROM OUR SERVICES WILL CREATE ANY WARRANTY NOT EXPRESSLY STATED IN THESE TERMS.</li>
</ol></li>
<li>LIMITS ON LIABILITY<ol>
<li>WE SHALL NOT BE LIABLE FOR DAMAGES OF ANY KIND (INCLUDING, BUT NOT LIMITED TO, ANY DIRECT, INCIDENTAL, GENERAL, SPECIAL, CONSEQUENTIAL, EXEMPLARY OR PUNITIVE DAMAGES) EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES, ARISING FROM OR RELATING TO: (A) THE USE OR INABILITY TO USE OUR SITE OR SERVICES; (B) HARM OR DAMAGE TO YOUR GOODS AS A RESULT OF USING OUR SITE OR SERVICES; (C) DISCLOSURE OF, UNAUTHORIZED ACCESS TO OR ALTERATION OF YOUR CONTENT; (D) ANY HARM TO YOU CAUSED IN WHOLE OR PART BY A THIRD PARTY, INCLUDING BUT NOT LIMITED TO ANOTHER USER OF THE SITE OR SERVICES; (E) STATEMENTS, CONDUCT OR OMISSIONS OF ANY BUYER, SELLER, OR OTHER THIRD PARTIES ON OUR SITE OR SERVICES; OR (F) YOUR OR ANYONE ELSE\'S CONDUCT OR ACTS IN CONNECTION WITH THE USE OF THE SITE OR SERVICES, INCLUDING WITHOUT LIMITATION FROM INTERACTIONS WITH OTHER USERS OF OUR SITE OR SERVICES OR PERSONS INTRODUCED TO YOU BY OUR SITE OR SERVICES, WHETHER ONLINE OR OFFLINE.</li>
<li>WE SHALL NOT BE LIABLE FOR ANY FAILURE OR DELAY IN PERFORMING UNDER THESE TERMS DUE TO CAUSES BEYOND OUR REASONABLE CONTROL, INCLUDING BUT NOT LIMITED TO ACTS OF NATURE AND POWER, INTERNET, AND EMAIL DISCONTINUITY.</li>
<li>EXCEPT AS SET FORTH IN SECTION 18, IN NO EVENT WILL OUR AGGREGATE LIABILITY TO YOU OR ANY THIRD PARTY IN ANY MATTER ARISING FROM OR RELATING TO OUR SITE OR SERVICES OR THESE TERMS EXCEED THE SUM OF ONE HUNDRED U.S. DOLLARS (USD $100).</li>
</ol></li>
<li>INDEMNITY. You agree to indemnify us and hold us (and each of our officers, directors, employees, agents, successors, assigns, and affiliates) harmless from any claim or demand, including reasonable attorneys\' fees and costs, made by any third parties arising out of or relating to your Content, your use of our Services, your violation of these Terms, your breach of any representations and warranties herein, or your violation of any rights of another. We will control any such defense and related settlement and you will reasonably assist us therewith and reimburse us for all out-of-pocket losses, costs and expenses.</li>
<li>REPORTING MISCONDUCT. If you interact or transact with any Seller or Buyer who you feel is acting or has acted inappropriately, including but not limited to offensive, violent or sexually inappropriate behavior, who you suspect of wrongdoing, or who engages in any other disturbing conduct, you should immediately report such person to the appropriate authorities and to SquareStays at help@SquareStays.com; provided that your report shall not obligate us to take any action beyond that required by law (if any) or cause us to incur any liability to you.</li>
<li>SquareStay&shy;s DMCA (Digital Millennium&shy; Copyright Act) and Copyright notificati&shy;on procedure:&shy; If you find that Content on SquareStay&shy;s is infringing&shy; your copyright,&shy; you will need to file a written record of this claim to us at legal@squa&shy;restays.co&shy;m. Please include in this message: A physical or electronic&shy; signature of the copyright owner or a person authorized&shy; to act on the owner&rsquo;s behalf; Identifica&shy;tion and descriptio&shy;n of the copyrighte&shy;d work(s) you claim to have been infringed;&shy; Identifica&shy;tion of the material you claim is infringing&shy; your copyrighte&shy;d work(s) that you would like removed, along with location (Universal&shy; Resource Locator or URL); Contact informatio&shy;n for the complainin&shy;g party so that we may reach you; A statement that the complainin&shy;g party has a good faith belief that use of the material is not authorized&shy; by the copyright owner, its agent(s), or the law; A statement that the informatio&shy;n in the written message is accurate, and under penalty of perjury, that the complainin&shy;g party is authorized&shy; to act on behalf of the copyright owner whose exclusive right is allegedly infringed.&shy; Please refer to sections 512(c)(3) and 512(f) for the relevant clauses surroundin&shy;g filing copyright infringeme&shy;nt claims and potential perjury and punishment&shy; actions. If you have filed a notice and wish to rescind it, please retract your notice by emailing legal@squa&shy;restays.co&shy;m with all relevant informatio&shy;n. After receiving and examining your notice, SquareStay&shy;s will notify the reported party, and, if appropriat&shy;e, remove the offending Content.</li>
<li>JURISDICTION AND VENUE. These Terms shall be interpreted in accordance with the laws of the Republic of Singapore, without regard to conflict-of-law principles. You and we agree to submit to the jurisdiction of a court located in Singapore. You agree that any action brought against SquareStays shall be venued in a court in the Republic of Singapore.</li>
<li>ATTORNEY&rsquo;S FEES. The prevailing party in any action brought under this agreement shall be entitled to reasonable attorney&rsquo;s fees and costs.</li>
<li>MISCELLANEOUS. These Terms contain the entire agreement, and supersede all prior and contemporaneous understandings between the parties. Our failure or delay in exercising any right, power or privilege under these Terms shall not operate as a waiver thereof. The invalidity or unenforceability of any of these Terms shall not affect the validity or enforceability of any other of these Terms, all of which shall remain in full force and effect. We may assign our rights and delegate our obligations under these Terms in whole or part to a third party. Headings of sections are for convenience only and shall not be used to limit or construe such sections. Sections 1.4 (Release), 4 (Privacy), 5.2 (License), 6 (Third-Party Content), 7 (Payment), 8 (Proprietary Rights), 14 (Limits on Liability), 15 (Indemnity), 17 (Jurisdiction and Venue), 18 (Attorney&rsquo;s Fees), and this Section 19 (Miscellaneous) shall survive any termination or expiration of these Terms.</li>
</ol>
<p>Please contact us at legal@SquareStays.com with any questions regarding these Terms.</p>
<p>Your continued use of this Site or Services and registration to use our Services is contingent upon your agreement to be bound by the foregoing Terms of Use.</p>
</div>', active: 1 )


Cmspage.create(page_title: "Fees", page_url: "fees", mandatory: true, description: '<div class="span16">
<h3>SquareStays Fees</h3>
<br />
<p>SquareStays is currently free of charge to all visiting Members. Listing members pay a 10% commission on the first month\'s rent.</p>
</div>', active: 1 )


Cmspage.create(page_title: "Privacy Policy", page_url: "privacy", mandatory: true, description: '<div class="span16">
<h3>Privacy Policy</h3>
<p>PLEASE READ THIS PRIVACY POLICY CAREFULLY AS IT CONTAINS IMPORTANT INFORMATION REGARDING YOUR LEGAL RIGHTS AND USAGE OF YOUR PRIVATE INFORMATION. THIS POLICY INCORPORATES THE SQUARESTAYS TERMS OF USE (HEREAFTER &ldquo;TERMS&rdquo;) BY ASSOCIATION. SEE <a href="/terms">WWW.SQUARESTAYS.COM/TERMS</a> FOR FULL TERMS.</p>
<p class="strong">Introduction</p>
<p>This Privacy Policy describes SquareStay\'s (operated by HeyPal Private Limited) (hereafter SquareStays or HeyPal) policies and procedures on the collection, use, sharing and disclosure of your information. SquareStays receives your information through various sources, including without limitation our various web sites, SMS, APIs, applications, services and third-parties (collectively "Services"). For example, you send us information when you use SquareStays from our web site, post or receive posts via SMS or email or other Services, add a SquareStays widget to your website, or access SquareStays from an application such as SquareStays on social networks or third-Party sites, or www.SquareStays.com. When using any of our Services you consent to the collection, transfer, manipulation, storage, disclosure and other uses of your information unless you specifically follow the opt-out provisions as described in this Privacy Policy. Irrespective of which country that you reside in or create information from, your information may be used by SquareStays in the Republic of Singapore or any other country where SquareStays operates.</p>
<p>If you have any questions or comments about this Privacy Policy, please contact us at <span style="text-decoration: underline;">privacy@SquareStays.com</span>.</p>
<br />
<p class="strong u">Information SquareStays Collects</p>
<p>SquareStays may collect and store the following information:</p>
<p><span class="strong">Information Collected Upon Registration:</span> When you create or configure a SquareStays account, you provide information, such as your name, password, and email address. Some of this information, for example, your name, may be listed publicly on our Services, including on a Place page and in search results.</p>
<p><span class="strong">Additional Information:</span> You may provide us with additional information to make public, such as your location, your Places pictures, or more information about yourself. You may customize your account with information such as a telephone number or email address for the delivery of messages or you may provide access to your address book so that we can help you find SquareStays users you know. Providing the additional information described here is entirely optional.</p>
<p><span class="strong">Content:</span> SquareStays is used to share Places with others. This includes when you list or post Places, upload or take photos, upload or record video, share links, make a comment, or send someone a message. If you do not want us to store metadata associated with content you share on SquareStays (such as photos), please remove the metadata before uploading the content.</p>
<p><span class="strong">Transactional Information.</span> We retain the details of transactions or payments you make through SquareStays.</p>
<p><span class="strong">Member Information.</span> We offer contact importer tools and connectors to social networks and other Third-Party Services to help you connect with and invite your friends on SquareStays. We store only a token to allow SquareStays to connect to these Third-Party Services on your behalf. We do not store your password(s) for these Third-Party Services.</p>
<p><span class="strong">Site activity information.</span> We keep track of some of the actions you take on SquareStays, such as adding Places, transacting Places with other Members, searching for Places, commenting on Places and so on. In some cases you are also taking an action when you provide information or content to us. For example, if you add an Place, in addition to storing the actual content you uploaded, we will log the fact that you shared it.</p>
<p><span class="strong">SquareStays and Third-Party Services:</span> We do not own or operate Third-Party applications or websites that you may use through or to connect to SquareStays. Whenever you connect with a Third-Party Service, we may receive information from them, including information about actions you take. In some cases, in order to personalize the process of connecting, we may receive a limited amount of information even before you connect with the Third-Party Service.</p>
<p><span class="strong">Information from other websites.</span> We may institute programs with advertising partners and other websites in which they share information with us. We may share information with them as well. This may include information about you, your Places, or your transactions. We may ask advertisers to tell us how Members respond to ads from our advertising partners. We may receive information about whether or not you&rsquo;ve seen or interacted with certain ads on other sites in order to measure the effectiveness of those ads.</p>
<p><span class="strong">Information from other Members.</span> We may collect information about you from other SquareStays users, such as reviews or comments on your Places, your transactions or other interactions with other SquareStays Members, or other related information.</p>
<p><span class="strong">Places, search results and other public information:</span> Our Services are primarily designed to help you enter into transactions (e.g., sale, purchase, loan, rental or lease) involving your physical goods or locations for accommodation ("Places"). Most of the information you provide to us is information you are asking us to convey to other Members. This includes the Places you add, the time when you added the Places, other past Places or transactions you have created, other Places you have posted about and many other bits of information. Our default is almost always to make the information you provide available to other Members but we allow you to control which Members or groups of Members can see the Places details. Information about Places is searchable by many search engines and may be delivered to a wide range of users and Third-Party Services. You should be careful about all information that will be made public by SquareStays.</p>
<p><span class="strong">Location Information:</span> You may choose to note your location in your content and in your SquareStays profile.</p>
<p><span class="strong">Log Data:</span> Our servers automatically record information ("Log Data") created by your use of the Services. Log Data may include information such as your IP address, browser type, the referring domain, pages visited, your mobile carrier or Internet Service Provider (ISP), device and application IDs, and search terms. Other actions, such as interactions with our website, applications and advertisements, may also be included in Log Data. If we haven&rsquo;t already deleted the Log Data earlier, we will either delete it or remove any common account identifiers, such as your username, full IP address, or email address, after 24 months.</p>
<p><span class="strong">Links:</span> SquareStays may keep track of how you interact with links in posts across our Services including third-party services and clients by redirecting clicks or through other means. We do this to help improve our Services, including advertising, and to be able to share aggregate click statistics such as how many times a particular link was clicked on.</p>
<p><span class="strong">Cookies:</span> Like many websites, we use "cookie" technology to collect additional website usage data and to improve our Services, but we may not require cookies for all parts of our Services. A cookie is a small data file that is transferred to your computer\'s hard disk. SquareStays may use both session cookies and persistent cookies to better understand how you interact with our Services, to monitor aggregate usage by our users and web traffic routing on our Services, and to improve our Services. Most Internet browsers automatically accept cookies. You can instruct your browser, by editing its options, to stop accepting cookies or to prompt you before accepting a cookie from the websites you visit.</p>
<p><span class="strong">Third-Party Services:</span> SquareStays uses a variety of services hosted by third parties to help provide our Services and to help us understand the use of our Services, such as Google Analytics. These services may collect information sent by your browser as part of a web page request, such as cookies or your IP request.</p>
<br />
<p class="strong u">Information Use, Sharing and Disclosure</p>
<p>We may use, share and disclose your information in the manner set forth below:</p>
<p><span class="strong">How We Use Information:</span> We collect and use your information to provide and measure use of our Services and improve them over time. You agree that we may use your personal information to:</p>
<ul>
<li style="color: black;">provide the services and customer support you request;</li>
<li style="color: black;">protect the rights or property of our Members;</li>
<li style="color: black;">resolve disputes, collect fees, and troubleshoot problems;</li>
<li style="color: black;">prevent potentially prohibited or illegal activities, and enforce the provisions of our Terms of Service;</li>
<li style="color: black;">customize, measure and improve our services, content and advertising;</li>
<li style="color: black;">tell you about our Services and those of our affiliates, targeted advertising, service updates, and promotional offers based on your preferences; and</li>
<li style="color: black;">compare information for accuracy, and verify it with third partiess.</li>
</ul>
<p><span class="strong">How We May Share and Disclose Information:</span> We share your information with third parties when we believe the sharing is permitted by you, reasonably necessary to offer our services, or when legally required to do so.</p>
<p><span class="strong">Use of Third-Party Services for Access.</span> We may share or disclose your information in certain cases, such as when you use Third-Party Services to access your SquareStays account. For instance, if you connect via a mobile application, some of your information may be disclosed to service providers who enable this access.</p>
<p><span class="strong">Personalized Advertising.</span> We don&rsquo;t share your information with advertisers without your consent. However, you are deemed to have given your consent to share your information with third parties if you do not follow the Opt-Out Procedure set forth below. Also, consent may be given by your actions. An example of consent would be if you asked us to provide your shipping address to an advertiser to receive a free sample or you enter into a SquareStays transaction with a commercial Member. We allow advertisers to choose the characteristics of Members who will see certain advertisements and we may use any of the non-personally identifiable attributes we have collected, including information you may have decided not to show to other Members to select the appropriate audience for those advertisements. For example, we might use your interest in electronics to show you ads for digital music players, but we do not tell any electronics company your name. Even though we do not share your information with advertisers without your consent, when you click on or otherwise interact with an advertisement there is a possibility that the advertiser may place a cookie in your browser. This is a Third-Party Service transaction outside of the control of SquareStays.</p>
<p><span class="strong">Information Shared with Marketers.</span> You may choose to share information with marketers or electronic commerce providers that are not associated with SquareStays through on-site or email newsletter offers. This is entirely at your discretion.</p>
<p><span class="strong">Search Engine Access.</span> Search engines will have broad access to certain information on our site. For example, your Places are searchable by many search engines and may be immediately delivered to a wide range of users and services.</p>
<p><span class="strong">Advertising Our Services.</span> We may ask advertisers outside of SquareStays to display ads promoting our services. We may ask them to deliver those ads based on the presence of a cookie, but in doing so will not share any other information with the advertiser.</p>
<p><span class="strong">Service Providers:</span> We engage certain trusted third parties to perform functions and provide services to us. We may share your personal information with these third parties to the extent necessary to perform these functions and provide such services, and only pursuant to obligations mirroring the protections of this privacy policy.</p>
<p><span class="strong">Law and Harm:</span> We may preserve or disclose your information if we believe that it is reasonably necessary to comply with a law, regulation or legal request; to protect the safety of any person; to address fraud, security or technical issues; or to protect SquareStays\'s rights or property.</p>
<p><span class="strong">Business Transfers:</span> In the event that SquareStays is involved in a bankruptcy, merger, acquisition, reorganization or sale of assets, your information may be sold or transferred as part of that transaction. The promises in this privacy policy will apply to your information as transferred to the new entity.</p>
<p><span class="strong">Non-Private or Non-Personal Information:</span> We may share or disclose your non-private, aggregated or otherwise non-personal information, such as your Places or the number of Members who clicked on a particular link.</p>
<br />
<p class="strong u">Information Protection</p>
<p><span class="strong">Information Security.</span> We keep your account information on a secured server behind a firewall. When you enter sensitive information (such as credit card numbers and passwords), we encrypt that information using secure socket layer technology (SSL). We generally do not store payment-related information, but leave that with Third-Party Service providers specialized in these tasks. We use automated and behavior-based measures to enhance security. If we detect, or believe we have detected, fraudulent or otherwise anomalous behavior, we may limit use of our Services or remove inappropriate content, or suspend or disable accounts for violations of these policies and agreements.</p>
<p><span class="strong">Risks inherent in online data.</span> Although SquareStays provides privacy options to limit access to information, please be aware that no security measures are perfect or impenetrable. SquareStays cannot control the actions of other Members with whom you share your information. We cannot guarantee that only authorized persons will view your information. We cannot ensure that private information you share on SquareStays will not become publicly available. We are not responsible for third party circumvention of any privacy settings or security measures on SquareStays. SquareStays recommends you use common sense security practices such as choosing a strong password, using different passwords for different services, and using up-to-date antivirus software.</p>
<p><span class="strong">Report Violations.</span> You should report any security violations to us.</p>
<br />
<p class="strong u">Opt-Out Procedure</p>
<p>You may opt out of certain SquareStays advertising and information sharing by unchecking selected boxes in your account settings. The names of these settings may change over time. You should check updates to your account settings and to this Privacy Policy from time to time. You can opt out of Personalized Advertising or display of your completed Transactions at any time.</p>
<br />
<p class="strong u">Deleting and Modifying Your Personal Information</p>
<p>If you are a registered Member of our Services, we provide you with tools to access or modify the personal information you provided to us and associated with your account.</p>
<p>You can also permanently delete your SquareStays account. If you follow the instructions on the site, your account will be deactivated and then deleted. When your account is deactivated, it is not viewable on SquareStays Services. For up to 30 days it is still possible to restore your account if it was accidentally or wrongfully deactivated. After 30 days, we delete your account from our systems.</p>
<p><span class="strong">Limitations on removal.</span> Even after you remove information from SquareStays or delete your account, copies of that information may remain viewable elsewhere to the extent it has been shared with other Members, or that it was otherwise distributed pursuant to your privacy settings, or that it was copied or stored by other Members or Third-Party Service providers. However, your name will no longer be associated with that information on SquareStays. Additionally, we will retain certain information to prevent identity theft and other misconduct even if you have deleted your account. SquareStays will retain certain necessary information relevant to transaction history with other SquareStays Members.</p>
<p><span class="strong">Backup copies.</span> Removed and deleted information may persist in backup copies for up to 180 days, but will not be available to others.</p>
<br />
<p class="strong u">Our Policy Towards Children</p>
<p>Our Services are not directed to people under 18 years old. If you become aware that any such person has provided us with personal information, please contact us at <span style="text-decoration: underline;">privacy@SquareStays.com</span>. We do not knowingly collect personal information from any persons under 18. If we become aware that any person under 18 has provided us with personal information, we take steps to remove such information and terminate the account.</p>
<br />
<p class="strong u">Changes to this Policy</p>
<p>We may revise this Privacy Policy from time to time. The most current version of the policy will govern our use of your information and will always be at <a href="/privacy">http://SquareStays.com/privacy</a>. If we make a change to this policy that we determine, in our sole discretion, is material, we will notify you via update or e-mail to the email associated with your account. By continuing to access or use the Services after those changes become effective, you agree to be bound by the revised Privacy Policy.</p>
</div>', active: 1 )


Cmspage.create(page_title: "Contact Information", page_url: "contact", mandatory: true, description: '<div class="span16 offset1">
<div class="span4">
<h3>Contact Information:</h3>
<p>SquareStays</p>
<p>HeyPal Pte Ltd</p>
<p>71 Ayer Rajah Crescent 07-05</p>
<p>Singapore 139951</p>
<p>support@squarestays.com</p>
</div>
<div class="span"><iframe src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=71+Ayer+Rajah+Crescent,+Singapore&amp;aq=0&amp;oq=71+Ayer+Rajah+Crescent&amp;sll=1.296767,103.786752&amp;sspn=0.006822,0.009602&amp;vpsrc=6&amp;g=71+Ayer+Rajah+Crescent,+Singapore+139951&amp;ie=UTF8&amp;hq=&amp;hnear=71+Ayer+Rajah+Crescent,+Singapore+139951&amp;ll=1.29677,103.786747&amp;spn=0.013644,0.019205&amp;t=m&amp;z=14&amp;output=embed" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" width="425" height="350"></iframe><br /><small><a style="color: #0000ff; text-align: left;" href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=71+Ayer+Rajah+Crescent,+Singapore&amp;aq=0&amp;oq=71+Ayer+Rajah+Crescent&amp;sll=1.296767,103.786752&amp;sspn=0.006822,0.009602&amp;vpsrc=6&amp;g=71+Ayer+Rajah+Crescent,+Singapore+139951&amp;ie=UTF8&amp;hq=&amp;hnear=71+Ayer+Rajah+Crescent,+Singapore+139951&amp;ll=1.29677,103.786747&amp;spn=0.013644,0.019205&amp;t=m&amp;z=14">View Larger Map</a></small></div>
</div>', active: 1 )


Cmspage.create(page_title: "Photography FAQ", page_url: "photo-faq", mandatory: false, description: %{<div class="info" id="photo_faq">
          <div class="intro span16">
            <h3>Photography FAQ</h3>
            <p>SquareStays helps connect people offering high-quality, flexible accommodations with professional tenants. This happens through the SquareStays site, helping you, as the lister, avoid costly screening of potential tenants. In order to do this, your listings should have the highest quality and most attractive photos possible. This guide is designed to help you provide the best photos you can for your listings on SquareStays.</p>
            <p>Some tips on how to get great photographs on SquareStays:</p>
          </div>
          <div class="span16">
            <div class="well expandable collapsed">
              <h4>1. Brighten it up</h4>
              <a class="read-more" href="#">read more...</a>
              <div class="inner" style="display: none; ">
                <img src="http://s3.amazonaws.com/squarestays-static/photos/tc2living3.jpg">
                <p>Photograph with natural daylight flooding into the room from the windows, and turn on the lights. This will give your space a friendly and bright atmosphere and help define the depth. That helps tenants understand the size of the space.</p>
                <p>If you have a professional or semi-professional camera, or a camera that allows manual control of the shutter speed, don't be afraid to experiment with overexposing by a stop or so to get a brighter shot. This holds especially true if you're photographing against windows during the day! To compensate for that bright daylight, your camera will try to adjust by dialing down the exposure times. This will result in dark and murky interiors. You will *have* to increase exposure times a bit, to get a friendly and bright interior shot. Don't worry if this results in blown out windows, the interior is what counts in this shot.</p>
                <p>If your space is too dark for well exposed handheld shots, get a tripod and mount your camera on it. With a tripod, you can dial the exposure times way up without getting blurry results.</p>
              </div>
            </div>
            <div class="well expandable collapsed">
              <h4>2. Go wide</h4>
              <a class="read-more" href="#">read more...</a>
              <div class="inner" style="display: none; ">
                <img src="http://s3.amazonaws.com/squarestays-static/photos/tc3living2.jpg">
                <p>Use the widest angle lens you have and/or zoom out all the way with your zoom. Full frame sensor SLR cameras are the best cameras for shooting interiors, because of their ability to capture wide angles and their strength in picking up light.</p>
                Wider angles make the interior look more spacious and give potential tenants a better idea of a room's layout.
                <p>This does not mean that you shouldn't take shots of some beautiful details. Find a balance between wide "establishing" shots, and a few "close-ups" of the details that define your space.</p>
                Carefully mixing shots will tell potential tenants a story about the space, and they will be more interested in renting it.
              </div>
            </div>
            <div class="well expandable collapsed">
              <h4>3. Shoot from a Corner</h4>
              <a class="read-more" href="#">read more...</a>
              <div class="inner" style="display: none; ">
                <img src="http://s3.amazonaws.com/squarestays-static/photos/tcwindows.jpg" style="display:none">
                <p>When shooting interior spaces, try to find a corner from which you can see the entire room. Shoot towards the opposite corner. This makes it easier to capture a bigger space, and makes for a more dynamic composition.</p>
              </div>
            </div>
            <div class="well expandable collapsed">
              <h4>4. Clean it up, liven it up</h4>
              <a class="read-more" href="#">read more...</a>
              <div class="inner" style="display: none; ">
                <img src="http://s3.amazonaws.com/squarestays-static/photos/tc2living6.jpg" style="display:none">
                <p>Before Taking any Photos, make sure your space isn't cluttered or messy.</p>
                <p>Conversely, if the space is not occupied at the time of your shooting, consider placing some props like bottles or flowers to give it a welcoming, lived-in appearance. Avoid props that are associated with clutter or stress, such as clothes, remotes or loose paper.</p>
              </div>
            </div>
            <div class="well expandable collapsed">
              <h4>5. Show the exterior</h4>
              <a class="read-more" href="#">read more...</a>
              <div class="inner" style="display: none; ">
                <img src="http://s3.amazonaws.com/squarestays-static/photos/tcentrance.jpg">
                <p>Guests will want to know what the property looks like from the outside. You should try and include some amenities on the exterior shots, such as the swimming pool, BBQ pits or garden area.</p>
              </div>
            </div>
            <div class="well expandable collapsed">
              <h4>6. Don't frame your shots digitally</h4>
              <a class="read-more" href="#">read more...</a>
              <div class="inner" style="display: none; ">
                <p>SquareStays will automatically frame your photo where necessary. There's no need for any manual framing, on the contrary, the additional frame may result in inconsistant results</p>
              </div>
            </div>
            <div class="well expandable collapsed">
              <h4>7. Don't add captions to your photos</h4>
              <a class="read-more" href="#">read more...</a>
              <div class="inner" style="display: none; ">
                <p>SquareStays allows you to add captions to your Photos with a single click in our Property Manager.</p>
              </div>
            </div>
            <div class="well">
              <h4>Don't be stingy! We've got space for your space</h4>
              <div class="inner">
                <p>SquareStays property listings are designed to accomodate lots of photos. A Listing with a dozen Photos of rooms, exteriors and amenities will quickly seem familiar to your potential guests, whereas a listing with just 3 or 4 shots may seem vague and undefined, making the decision to rent that much harder!</p>
              </div>
            </div>
          </div>
        </div>
        <script> Expandable.initialize("#photo_faq"); </script>
  }, active: 1)

  end

  def down
  end
end
