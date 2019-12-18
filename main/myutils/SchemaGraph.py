class SchemaGraph:
	'Class for creating Schema File from reading schema_file,fk_file,ix_file,hist_dir'

	def __init__(self,schema_file,fk_file,ix_file,hist_dir):
		self.relations, self.fk_constraints, self.indexes = {}, {}, {}
		fix_types, var_types = ['date','time','integer','char'], ['varchar','decimal']

		'#### Parse Schema File Here ####'
		def relation_builder(self,relation_name,relation_description):
			# print('\n',relation_name)
			# for line in relation_description: print('\t',line)
			self.relations[relation_name] = {'attrs':{}}
			pk_creator, not_null_placer = 'primary key','not null'
			for line in relation_description:
				if pk_creator in line:
					primary_key = tuple(line[line.index(pk_creator)+len(pk_creator):].strip().strip('()').strip().split(','))
					self.relations[relation_name]['primary_key'] = primary_key
				else:
					for typ in var_types+fix_types:
						if typ in line:
							break
					else:
						raise Exception('Type not found for defined attribute\n{}'.format(relation_name,line))
					attr_name = line[:line.index(typ)].strip()
					self.relations[relation_name]['attrs'][attr_name] = { 'type':typ, 'not_null':(not_null_placer in line) }
					if typ in var_types:
						self.relations[relation_name]['attrs'][attr_name]['extn'] = eval(line[line.index('('):line.index(')')+1])
			pass
		relation_creator = 'create table'
		with open(schema_file) as schema_handle:
			for line in schema_handle.readlines():
				line = line.strip()
				if line and not line.startswith('--'):
					if relation_creator in line: # Start of SQL command for creating relation
						relation_name = line[line.index(relation_creator)+len(relation_creator):].strip().strip('(').strip()
						relation_description   = []
					elif ';' in line: # End of SQL command for creating relation
						relation_builder(self,relation_name,relation_description)
						del relation_name, relation_description
					elif line=='(': #Just a Starting bracket placed in separate line
						pass
					else: # Statment within Relation definition for attribute or primary key
						relation_description.append(line.strip().strip(',').strip())

		'#### Parse Foreign-Key File Here ####'
		# rltn1.attr1->rltn2.attr2, Description for Foreign-Key interpretation
		def fk_builder(self,fkc_name,r1,a1,r2,a2):
			# print(fkc_name,(r1,a1),(r2,a2))
			self.fk_constraints[(fkc_name,(r1,a1))] = (r2,a2)
			pass
		relation_alter, constraint_creator, fk_creator, ref_creator = 'alter table', 'add constraint', 'foreign key', 'references'
		with open(fk_file) as fk_handle:
			for line in fk_handle.readlines():
				line = line.strip().strip(';').strip()
				if line and not line.startswith('--'):
					r1 = line[ line.index(relation_alter)+len(relation_alter) : line.index(constraint_creator) ].strip()
					a1 = line[ line.index(fk_creator)+len(fk_creator)         : line.index(ref_creator)        ].strip().strip('()').strip()
					t  = line[ line.index(ref_creator)+len(ref_creator)       :                                ].strip()
					r2 = t[:t.index('(')].strip()
					a2 = t[t.index('('):].strip().strip('()').strip()
					fkc_name = line[ line.index(constraint_creator)+len(constraint_creator) : line.index(fk_creator) ].strip()
					fk_builder(self,fkc_name,r1,a1,r2,a2)

		'#### Parse Index File Here ####'
		# rltn.attr, Description for Index interpretation
		def ix_builder(self,ix_name,r,a):
			# print((r,a))
			self.indexes[(ix_name,r,a)] = None
			pass
		ix_creator, ix_placer = 'CREATE INDEX', 'ON'
		with open(ix_file) as ix_handle:
			for line in ix_handle.readlines():
				line = line.strip().strip(';').strip()
				if line and not line.startswith('--'):
					t = line[ line.index(ix_placer)+len(ix_placer) : ].strip()
					r = t[:t.index('(')].strip()
					a = t[t.index('('):].strip().strip('()').strip()
					ix_name = line[ line.index(ix_creator)+len(ix_creator) : line.index(ix_placer) ].strip()
					ix_builder(self,ix_name,r,a)

		'Parse Histograms Directory Here'
		pass

		'Finalising SchemaGraph Object'
		pass


if __name__ == '__main__':
	schema_file = 'C:\\ACHINT\\shubhi\\dbproject\\pg_tpcds_master\\tpcds-create.sql' #input('Enter Schema File\n')
	fk_file     = 'C:\\ACHINT\\shubhi\\dbproject\\pg_tpcds_master\\tpcds-ri.sql'     #input('Enter Foreign-Key File\n')
	ix_file     = 'C:\\ACHINT\\shubhi\\dbproject\\pg_tpcds_master\\tpcds-index.sql'  #input('Enter Index File\n')
	hist_dir    = 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\histograms'                  #input('Enter Histogram Path\n')
	SchemaGraph_obj = SchemaGraph(schema_file,fk_file,ix_file,hist_dir)	