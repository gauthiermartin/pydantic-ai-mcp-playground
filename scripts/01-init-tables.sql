-- Create example tables
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insert example data
-- Create 5 users
INSERT INTO users (username, email) VALUES
    ('john_doe', 'john.doe@example.com'),
    ('jane_smith', 'jane.smith@example.com'),
    ('alex_wilson', 'alex.wilson@example.com'),
    ('sarah_johnson', 'sarah.johnson@example.com'),
    ('mike_brown', 'mike.brown@example.com');

-- Insert 20 posts for each of the 5 users (total: 100 posts)
INSERT INTO posts (user_id, title, content) VALUES
    -- Posts for user 1 (John Doe)
    (1, 'Getting Started with Programming', 'My journey into the world of coding begins today.'),
    (1, 'Python Fundamentals', 'Learning about variables, functions, and control structures.'),
    (1, 'Data Structures Explained', 'An overview of lists, dictionaries, sets, and tuples.'),
    (1, 'Web Development Basics', 'HTML, CSS, and JavaScript fundamentals.'),
    (1, 'Database Design', 'Relational database concepts and normalization.'),
    (1, 'API Development', 'Creating RESTful APIs with Flask.'),
    (1, 'Authentication Systems', 'Implementing secure user authentication.'),
    (1, 'Testing Strategies', 'Unit tests, integration tests, and TDD.'),
    (1, 'DevOps Practices', 'CI/CD pipelines and deployment automation.'),
    (1, 'Cloud Computing', 'Working with AWS services.'),
    (1, 'Containerization', 'Docker and container orchestration.'),
    (1, 'Microservices', 'Breaking down monoliths into microservices.'),
    (1, 'Security Best Practices', 'Protecting applications from common vulnerabilities.'),
    (1, 'Performance Optimization', 'Techniques for improving application performance.'),
    (1, 'Machine Learning Intro', 'Basic ML concepts and algorithms.'),
    (1, 'Data Visualization', 'Creating meaningful visualizations with Python libraries.'),
    (1, 'Open Source Contributions', 'How to contribute to open source projects.'),
    (1, 'Code Quality', 'Writing clean, maintainable code.'),
    (1, 'Design Patterns', 'Common software design patterns explained.'),
    
    
    -- Posts for user 2 (Jane Smith)
    (2, 'UX Research Methods', 'Effective user research techniques for product design.'),
    (2, 'Wireframing Tools', 'Comparing popular wireframing and prototyping tools.'),
    (2, 'Color Theory', 'Using color effectively in interface design.'),
    (2, 'Typography Basics', 'Font selection and text hierarchy in design.'),
    (2, 'Design Systems', 'Creating consistent component libraries.'),
    (2, 'Mobile-First Design', 'Designing for various screen sizes and devices.'),
    (2, 'Accessibility in Design', 'Making interfaces accessible to all users.'),
    (2, 'User Testing', 'Methods for testing prototypes with users.'),
    (2, 'Information Architecture', 'Organizing content for better user experience.'),
    (2, 'Visual Hierarchy', 'Guiding users through interfaces effectively.'),
    (2, 'Interaction Design', 'Creating engaging user interactions.'),
    (2, 'Animation in UI', 'Using motion to enhance user experience.'),
    (2, 'Design Thinking', 'Problem-solving approach for innovation.'),
    (2, 'Usability Heuristics', 'Principles for usable interface design.'),
    (2, 'Design Critique', 'How to give and receive design feedback.'),
    (2, 'UI Design Trends', 'Current trends in user interface design.'),
    (2, 'Design Portfolio', 'Building an effective design portfolio.'),
    (2, 'Design Collaboration', 'Working effectively with developers and stakeholders.'),
    
    
    -- Posts for user 3 (Alex Wilson)
    (3, 'Data Science Workflow', 'End-to-end process of a data science project.'),
    (3, 'Exploratory Data Analysis', 'Techniques for initial data investigation.'),
    (3, 'Statistical Methods', 'Essential statistics for data analysis.'),
    (3, 'Data Cleaning', 'Preparing messy data for analysis.'),
    (3, 'Feature Engineering', 'Creating meaningful features from raw data.'),
    (3, 'Supervised Learning', 'Classification and regression techniques.'),
    (3, 'Unsupervised Learning', 'Clustering and dimensionality reduction.'),
    (3, 'Time Series Analysis', 'Working with temporal data patterns.'),
    (3, 'Natural Language Processing', 'Text analysis and processing techniques.'),
    (3, 'Computer Vision', 'Image recognition and processing algorithms.'),
    (3, 'Deep Learning', 'Neural networks and deep learning architectures.'),
    (3, 'Model Evaluation', 'Metrics for assessing model performance.'),
    (3, 'Model Deployment', 'Putting machine learning models into production.'),
    (3, 'Big Data Technologies', 'Tools for handling large-scale data.'),
    (3, 'Data Ethics', 'Ethical considerations in data science.'),
    (3, 'Data Visualization Best Practices', 'Creating effective data visualizations.'),
    
    
    -- Posts for user 4 (Sarah Johnson)
    (4, 'Project Management Basics', 'Core principles of managing software projects.'),
    (4, 'Agile Methodologies', 'Scrum, Kanban, and other agile frameworks.'),
    (4, 'Sprint Planning', 'Setting up effective sprint cycles.'),
    (4, 'Backlog Management', 'Prioritizing and refining the product backlog.'),
    (4, 'Stakeholder Communication', 'Keeping stakeholders informed and engaged.'),
    (4, 'Risk Management', 'Identifying and mitigating project risks.'),
    (4, 'Team Leadership', 'Leading development teams effectively.'),
    (4, 'Product Vision', 'Creating and maintaining product direction.'),
    (4, 'User Stories', 'Writing effective user stories and acceptance criteria.'),
    (4, 'Estimation Techniques', 'Approaches to estimating development work.'),
    (4, 'Metrics and KPIs', 'Measuring project and team performance.'),
    (4, 'Remote Team Management', 'Leading distributed development teams.'),
    (4, 'Project Documentation', 'Essential documentation for software projects.'),
    (4, 'Release Management', 'Planning and executing software releases.'),
    (4, 'Team Building', 'Creating cohesive development teams.'),
    (4, 'Conflict Resolution', 'Addressing conflicts within teams.'),
    (4, 'Technical Debt', 'Managing and reducing technical debt.'),
    (4, 'Cross-functional Collaboration', 'Working with design, marketing, and sales teams.'),
    (4, 'Continuous Improvement', 'Implementing retrospectives and improvement cycles.'),
    (4, 'Product Management Career', 'Growing as a product manager.'),
    (4, 'A/B Testing', 'Designing and analyzing experiments.'),
    (4, 'Recommendation Systems', 'Building personalized recommendation algorithms.'),
    (4, 'Anomaly Detection', 'Finding outliers and unusual patterns in data.'),
    (4, 'Data Science Career Path', 'Growing as a data scientist.'),
    
    -- Posts for user 5 (Mike Brown)
    (5, 'System Architecture', 'Designing scalable software architectures.'),
    (5, 'Distributed Systems', 'Principles of distributed computing.'),
    (5, 'Cloud Infrastructure', 'Building on AWS, Azure, and Google Cloud.'),
    (5, 'Networking Fundamentals', 'Key concepts in computer networking.'),
    (5, 'Security Architecture', 'Designing secure systems and networks.'),
    (5, 'Infrastructure as Code', 'Managing infrastructure with Terraform and CloudFormation.'),
    (5, 'Kubernetes', 'Container orchestration and management.'),
    (5, 'Serverless Computing', 'Building applications with serverless architectures.'),
    (5, 'Database Technologies', 'SQL, NoSQL, and database selection criteria.'),
    (5, 'High Availability', 'Designing systems for maximum uptime.'),
    (5, 'Disaster Recovery', 'Planning for system failures and recovery.'),
    (5, 'Monitoring and Logging', 'System observability and troubleshooting.'),
    (5, 'Performance Engineering', 'Optimizing system performance.'),
    (5, 'Cost Optimization', 'Managing cloud infrastructure costs.'),
    (5, 'DevOps Culture', 'Bridging development and operations.'),
    (5, 'Site Reliability Engineering', 'SRE practices and principles.'),
    (5, 'Automation Strategies', 'Automating infrastructure and operations tasks.'),
    (5, 'Incident Management', 'Responding to and learning from system incidents.'),
    (5, 'Technical Leadership', 'Leading architecture and engineering decisions.'),
    (5, 'System Design Interviews', 'Preparing for system design discussions.'),
    (5, 'Career Development', 'Growing as a software developer.'),
    (5, 'Design Ethics', 'Ethical considerations in product design.'),
    (5, 'Design Leadership', 'Growing from designer to design leader.');
